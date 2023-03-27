#pragma once

#ifndef __PING_H__
#define __PING_H__

#include <inttypes.h>

typedef uint8_t MACAddress[6];

typedef uint32_t IPAddress;

typedef enum tagPingMode {
    None,
    Address,
    File
} PingMode;

typedef struct _tagPingOptions
{
    PingMode Mode;
    IPAddress Address;
    uint32_t Mask;
    int      CIDR;
    char* AddressFilename;
    int     PingSize;
    int     Timeout;
    int     Retries;
    bool    ShowAvg;
    bool    ShowMin;
    bool    ShowMAC;  
    bool    ShowTime;
    bool    HideUnavailable;    
    bool    Resolve;    
    bool    ShowTTL;
    bool    Continuos;        
    bool    ShowHelp;    
    bool    ShowStatistics;
    bool    ShowManufacturer;
    char* Filter;
    char* OutputFilename;
} PingOptions, *PPingOptions; 

typedef struct tagManufacturerInfo {
    char* NameEn;
    char* NameRu;
    char* Address;
    char* Country;
    char* CountryCode;
} ManufacturerInfo, *PPManufacturerInfo;

typedef bool TextWriteProc(char* text);

typedef bool InfoWriteProc(uint32_t address, int size, int time,
    int ttl, char* mac, char* name, int recevied, int total, char* manufacturer);

bool PingByList(IPAddress list[], int len, PingOptions options);
bool Ping(IPAddress address, int pingSize, int timeOut, int* time, int* ttl);
bool PingNormalMode(IPAddress address, PingOptions options, bool continuos);
char* IpToStr(IPAddress address);
bool StrToIp(char* value, IPAddress* address, int* mask);

bool SetCallback(TextWriteProc textWrite, InfoWriteProc infoWrite, TextWriteProc progress);

uint32_t CidrToMask(int cidr);
bool GetMAC(IPAddress address, char** mac);
bool GetMAC(IPAddress address, MACAddress*);
bool OpenDb();
bool GetManufacturer(int oid, ManufacturerInfo* pInfo);
bool CloseDb();
void Manufacturer_Free(ManufacturerInfo*);

#endif