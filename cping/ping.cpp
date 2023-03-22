#include "ping.h"

#include <winsock2.h>
#include <ws2tcpip.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <iphlpapi.h>
#include <icmpapi.h>
#include <windows.h>
#include <winbase.h>


#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib, "Ws2_32.lib")

#ifdef cplusplus
extern "C" {
#endif

bool GetMAC(IPAddress address, char** mac)
{
	int res;
	uint8_t raw[6];
	int len;
	memset(&raw, 0, 6);
	const char* nibbles = "0123456789ABCDEF";
	res = SendARP(htonl((unsigned int)address), 0, &raw[0], (PULONG)&len);
	if (res == 0)
	{
		*mac = new char[19];
		char* j = *mac;
		for (int i = 0; i < 6; i++)
		{
			*j++ = nibbles[(raw[i] >> 4) & 0x0F];
			*j++ = nibbles[raw[i] & 0x0F];
			if (i < 5)
				*j++ = '-';
		}
		*j = 0;
		return true;
	}
	else
	{
		*mac = (char*)"N/A";
		return false;
	}
}

char* IpToStr(IPAddress address)
{
	char* output = new char[16];
	sprintf_s(output, 16, "%d.%d.%d.%d", (address >> 24) & 0xFF, (address >> 16) & 0xFF, (address >> 8) & 0xFF, address & 0xFF);
	return output;
}

bool StrToIp(char* value, IPAddress* address, int* mask)
{
	int len = strlen(value);
	*address = 0;
	*mask = -1;
	int i = len;
	*address = 0;
	int step = 0;
	unsigned char octet = 0;
	int maskStart = -1;
	for (int i = 0; i < len; i++)
	{
		if (value[i] == ' ')
			continue;
		if (value[i] == '.')
		{
			*address = ((*address & 0xFFFFFF00) | octet) << 8;
			step++;
			if ((step > 3) && (i < len))
				return false;
			octet = 0;
			continue;
		}
		if (value[i] == '/')
		{
			maskStart = i;
			break;
		}
		if ((value[i] >= 0x30) && (value[i] <= 0x39))
		{
			octet = octet * 10 + (value[i] - 0x30);
			if (octet > 255)
				return false;
		}
	}
	*address = ((*address & 0xFFFFFF00) | octet);
	char* strMask = &value[maskStart + 1];
	*mask = atoi(strMask);
	return true;
}

bool GetHostName(IPAddress address, char** name)
{	
	struct sockaddr_in sa;
	memset(&sa, 0, sizeof(struct sockaddr));
	sa.sin_family = AF_INET;
	sa.sin_addr.s_addr = address;
	sa.sin_port = 0;
	*name = new char[80];
	int error_no;
	if ((error_no = GetNameInfoA((struct sockaddr*)&sa, sizeof(struct sockaddr), *name, 80, NULL, 0,0)) != 0)	
	{
		delete* name;
		*name = new char[10];
		_itoa_s(error_no, *name, 10, 16);
		return false;
	}
	else
	{
		return true;
	}
}

bool breakPing;
bool showStatistics;
TextWriteProc* progressOutProc;
TextWriteProc* textWriteProc;
InfoWriteProc* infoWriteProc;
int status;

const char* errorMessages[] = {
	"Буфер слишком мал",
	"Сеть назначения недоступна",
	"Хост назначения недоступен",
	"Протокол узлом назначения не поддерживается",
	"Порт назначения недоступен",
	"Нет ресурсов",
	"Неверная опция IP",
	"Аппаратная ошибка IP",
	"IP пакет слишком большой",
	"Превышен интервал ожидания запроса",
	"Неверный запрос",
	"Неверный маршрут",
	"Превышено значение передачи TTL",
	"Превышено значение TTL",
	"Проблема в параметре",
	"IP_SOURCE_QUENCH",
	"Дополнение слишком большое",
	"Неверное назначение",
	"Адрес удален",
	"Изменились настройки MTU",
	"Изменился MTU",
	"IP_UNLOAD",
	"Общий сбой" };

const char* PingStatusToStr(int status)
{
	if (status == 0)
		return "Успешно";
	else if ((status >= 11001) && (status < 11022))
		return errorMessages[status - 11001];
	else if (status == 11050)
		return "Общий сбой";
	else
	{
		return "";
	}
}

typedef struct _tagOptionInformation {
	uint8_t		ttl;
	uint8_t		tos;
	uint8_t		flags;
	uint8_t		optionsSize;
	void*		optionsData;
} OptionInformation, *POptionInformation;

typedef struct _tagIcmpEchoReply {
	IPAddress	address;
	int32_t		status;
	int32_t		roundTrimTime;
	uint16_t	datasize;
	uint16_t	reserved1;
	void*		dataPointer;
	OptionInformation options;
	uint8_t		data[256];
} IcmpEchoReply, *PIcmpEchoReply;

bool Ping(IPAddress address, int pingSize, int timeout, int* time, int* ttl) 
{
	bool result = false;
	IcmpEchoReply reply;
	try
	{
		HANDLE port = IcmpCreateFile();
		memset(&reply, 0, sizeof(reply));
		status = IcmpSendEcho(port, ntohl((int)address), &reply.data[0], pingSize, NULL, (void*)&reply, sizeof(reply) + pingSize, timeout);
		if (status > 0)
		{
			status = reply.status;			
			*ttl = reply.options.ttl;
			*time = reply.roundTrimTime;			
		}
		else
		{
			status = GetLastError();			
		}
		IcmpCloseHandle(port);
		return status == 0;
	}
	catch (...)
	{
		return false;
	}
}

void InternalTextWrite(const char* format, ...)
{
	if (textWriteProc != NULL)
	{
		va_list args;
		va_start(args,format);
		char* line = new char[513];
		vsprintf_s(line, 513, format, args);
		textWriteProc(line);
		delete line;
	}
}

bool __stdcall CtrlHandler(unsigned int ctrlType)
{
	if (ctrlType == CTRL_C_EVENT)
	{
		breakPing = true;
		return true;
	}
	else if (ctrlType == CTRL_BREAK_EVENT)
	{
		showStatistics = true;
		return true;
	}
	else if (ctrlType == CTRL_CLOSE_EVENT)
	{
		exit(0);
		return true;
	}
	else
		return false;
}

bool PingByList(IPAddress list[], int len, PingOptions options)
{
	bool available = false;
	int avgTime, maxTime, received, total;	
	char* mac = NULL;
	char* name = NULL;
	int rTime = 0, ttl = 0;
	SetConsoleCtrlHandler(NULL, false);
	SetConsoleCtrlHandler((PHANDLER_ROUTINE)&CtrlHandler, true);
	for (int i = 0; i < len; i++)
	{
		if (progressOutProc != NULL)
		{
			char* buffer = new char[100];
			memset(buffer, 0, 100);
			char* address = IpToStr(list[i]);
			sprintf_s(buffer,100, "Scanning (%d%%) adddress %s ...", lrint((i + 1.0) / len * 100), address);
			progressOutProc(buffer);
			delete buffer;
			delete address;
		}
		if (breakPing)
		{
			InternalTextWrite((char*)"Прервано пользователем\n");
			break;
		}
		available = false;
		avgTime = 0;
		maxTime = -1;
		received = 0;
		total = 0;
		for (int j = 0; j < options.Retries; j++)
		{
			
			if (Ping(list[i], options.PingSize, options.Timeout, &rTime, &ttl))
			{
				available = true;
				if (options.ShowAvg)
					avgTime += rTime;
				else if (maxTime < rTime)
					maxTime = rTime;
				received++;
			}
			total++;
		}
		if (options.ShowAvg)
		{
			if (received > 0)
				avgTime = lrint(((double)avgTime) / received);
			else
				avgTime = -1;
		}
		else
			avgTime = maxTime;
		if (available)
		{
			if (options.ShowMAC)
				if (!GetMAC(list[i], &mac))
					mac = NULL;
			if (options.Resolve)
			{
				if (!GetHostName(list[i], &name))
					name = NULL;
			}
		}
		else
		{
			name = NULL;
			mac = NULL;
		}
		if (available || (!options.HideUnavailable))
		{
			char* line = new char[80];
			line[79] = 0;
			memset(line, 32, 79);
			if (progressOutProc != NULL)
				progressOutProc(line);
			infoWriteProc(list[i], options.PingSize, avgTime, ttl, mac, name, total, received);
		}
		if (name != NULL)
		{
			delete name;
		}
		if (mac != NULL)
			delete mac;
	}
	SetConsoleCtrlHandler((PHANDLER_ROUTINE)&CtrlHandler, false);
	return true;
}

bool PingNormalMode(IPAddress address, PingOptions options, bool continuos)
{
	char* mac;
	char* name;
	int rTime, ttl;
	int maxTime = -1, avgTime = 0, received = 0, minTime = INT_MAX;
	char* strAddress = IpToStr(address);
	if (options.ShowMAC || options.Resolve)
	{
		InternalTextWrite("Information about %s", strAddress);
		mac = NULL;
		if (options.ShowMAC && GetMAC(address, &mac))
			InternalTextWrite("MAC address: %s", mac);
		if (options.Resolve && GetHostName(address, &name))
			InternalTextWrite("Host name: %s", name);
	}
	InternalTextWrite("Pinging %s with packet size %d bytes", strAddress, options.PingSize);
	if (options.Continuos)
		SetConsoleCtrlHandler((PHANDLER_ROUTINE)&CtrlHandler, true);
	int i = 0;
	while ((i++ < options.Retries) || (options.Continuos))
	{
		if (Ping(address, options.PingSize, options.Timeout, &rTime, &ttl))
		{
			InternalTextWrite("Response from %s: response time = %ims, size %d bytes, ttl=%d\n", strAddress, rTime, options.PingSize, ttl);
			received++;
			avgTime += rTime;
			if (rTime < minTime)
				minTime = rTime;
			if (rTime > maxTime)
				maxTime = rTime;
		}
		else
			InternalTextWrite("%s\n", PingStatusToStr(status));
		if (breakPing)
			break;
		Sleep(1000);
	}
	if (options.ShowStatistics)
	{
		InternalTextWrite("Ping statictics for %s:\n", strAddress);
		InternalTextWrite("  Packets: sent = %d, received = %d\n", i, received, i - received);
		if (i != 0)
			InternalTextWrite("  Loses: %.1f%%\n", ((double)(i - received) / ((double)i) * 100.0));
		if (received != 0)
			InternalTextWrite("  Average round trip time: %d ms\n", avgTime / received);
		else
			InternalTextWrite("  Average round trip time is unavailable due unreachable host\n");
		InternalTextWrite("  Minimum time: %d ms, Maximum: %d ms\n", minTime, maxTime);
	}
	if (options.Continuos)
		SetConsoleCtrlHandler((PHANDLER_ROUTINE)&CtrlHandler, false);
	return true;
}

bool SetCallback(TextWriteProc textWrite, InfoWriteProc infoWrite, TextWriteProc progress)
{
	textWriteProc = textWrite;
	infoWriteProc = infoWrite;
	progressOutProc = progress;
	return true;
}

uint32_t CidrToMask(int cidr)
{
	uint32_t mask = 0xFFFFFFFF;
	cidr = (cidr - 1) & 0x1F;
	for (int i = 31 - cidr; i--; i > 0)
		mask <<= 1;
	return mask;
}
#ifdef cplusplus
}
#endif