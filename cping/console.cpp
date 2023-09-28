#include "console.h"
#include <inttypes.h>
//#include <winbase.h>
#include <windows.h>

//Local variables
 int LastMode;
 unsigned char TextAttr;
 unsigned short WindowMin;
 unsigned short WindowMax;
 bool MouseInstalled;
 unsigned short MousePressedButtons;

HANDLE hConsoleInput;
HANDLE hConsoleOutput;

unsigned short StartAttr;
int LastX, LastY;
int OldCodePage;
int MouseRowWidth, MouseColWidth;
int MousePosX, MousePosY;
bool MouseButtonPressed;
long long MouseEventTime;

SMALL_RECT ConsoleScreenRect;

bool KeyPressed()
{
    DWORD numRead;
    DWORD numberOfEvents;
    bool pressed = false;
    INPUT_RECORD inputRecord;
    GetNumberOfConsoleInputEvents(hConsoleInput, &numberOfEvents);
    if (numberOfEvents > 0)
    {
        if (PeekConsoleInput(hConsoleInput, &inputRecord, 1,  & numRead))
        {
            if ((inputRecord.EventType == KEY_EVENT) &&
                (inputRecord.Event.KeyEvent.bKeyDown))
            {
                pressed = true;
                MouseButtonPressed = false;
            }
            else
            {
                if (inputRecord.EventType == MOUSE_EVENT)
                {
                    MousePosX = inputRecord.Event.MouseEvent.dwMousePosition.X;
                    MousePosY = inputRecord.Event.MouseEvent.dwMousePosition.Y;
                    if (inputRecord.Event.MouseEvent.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED)
                    {
                        MouseEventTime = GetTickCount64();
                        MouseButtonPressed = true;
                    }
                }
                ReadConsoleInput(hConsoleInput, &inputRecord, 1, &numRead);
            }
        }
    }
    return pressed;
}

char ReadKey()
{
    DWORD numRead;
    INPUT_RECORD inputRecord;
    do
    {
        ReadConsoleInput(hConsoleInput, &inputRecord, 1, &numRead);
    } while (inputRecord.Event.KeyEvent.uChar.AsciiChar == 0);
    return inputRecord.Event.KeyEvent.uChar.AsciiChar;
}

void TextMode(int mode)
{

}

void Window(int left, int top, int right, int bottom)
{
    ConsoleScreenRect.Left = left - 1;
    ConsoleScreenRect.Top = top - 1;
    ConsoleScreenRect.Right = right - 1;
    ConsoleScreenRect.Bottom = bottom - 1;
    WindowMin  = (ConsoleScreenRect.Top << 8) | ConsoleScreenRect.Left;
    WindowMax = (ConsoleScreenRect.Bottom << 8) | ConsoleScreenRect.Right;
    SetConsoleWindowInfo(hConsoleOutput, true, &ConsoleScreenRect);
    GotoXY(1, 1);
}

void GotoXY(int x, int y)
{
    COORD coord{};
    coord.X = x - 1 + ConsoleScreenRect.Left;
    coord.Y = y - 1 + ConsoleScreenRect.Top;
    if (!SetConsoleCursorPosition(hConsoleOutput, coord))
    {
        int error = GetLastError(); 
        if (error == 0)
            GotoXY(1, 1);
        DelLine();
    }
}

int WhereX()
{
    CONSOLE_SCREEN_BUFFER_INFO cbi;
    GetConsoleScreenBufferInfo(hConsoleOutput, &cbi);
    return cbi.dwCursorPosition.X + 1 - ConsoleScreenRect.Left;
}

int WhereY()
{
    CONSOLE_SCREEN_BUFFER_INFO cbi;
    GetConsoleScreenBufferInfo(hConsoleOutput, &cbi);
    return cbi.dwCursorPosition.Y+ 1 - ConsoleScreenRect.Top;
}

void ClrScr()
{
    FillerScreen(' ');
}

void ClrEol()
{
    COORD coord;
    DWORD count, size;
    coord.X = WhereX() - 1 + ConsoleScreenRect.Left;
    coord.Y = WhereY() - 1 + ConsoleScreenRect.Top;
    size = ConsoleScreenRect.Right - coord.X + 1;
    FillConsoleOutputAttribute(hConsoleOutput, TextAttr, size, coord, &count);
    FillConsoleOutputCharacter(hConsoleOutput, ' ', size, coord, &count);
}

void InsLine()
{
    SMALL_RECT sourceScreenRect;
    COORD coord;
    CHAR_INFO ci;
    DWORD size, count;
    sourceScreenRect = ConsoleScreenRect;
    sourceScreenRect.Top = WhereY() - 1 + ConsoleScreenRect.Top;
    sourceScreenRect.Bottom = ConsoleScreenRect.Bottom - 1;
    ci.Char.AsciiChar = ' ';
    ci.Attributes = TextAttr;
    coord.X = sourceScreenRect.Left;
    coord.Y = sourceScreenRect.Top+1;
    size = sourceScreenRect.Right - sourceScreenRect.Left + 1;    
    ScrollConsoleScreenBuffer(hConsoleOutput, &sourceScreenRect, NULL, coord, &ci);
    coord.Y--;
    FillConsoleOutputAttribute(hConsoleOutput, TextAttr, size, coord, &count);
}

void DelLine() 
{
    SMALL_RECT sourceScreenRect = ConsoleScreenRect;
    COORD coord;
    CHAR_INFO ci;
    DWORD size, count;
    sourceScreenRect.Top = WhereY() + ConsoleScreenRect.Top;
    ci.Char.AsciiChar = ' ';
    ci.Attributes = TextAttr;
    coord.X = sourceScreenRect.Left;
    coord.Y = sourceScreenRect.Top - 1;
    size = sourceScreenRect.Right - sourceScreenRect.Left + 1;
    ScrollConsoleScreenBuffer(hConsoleOutput, &sourceScreenRect, NULL, coord, &ci);
    FillConsoleOutputAttribute(hConsoleOutput, TextAttr, size, coord, &count);
}

void TextColor(int color)
{
    LastMode = TextAttr;
    TextAttr = (color & 0x0F) | (TextAttr & 0xF0);
    SetConsoleTextAttribute(hConsoleOutput, TextAttr);
}

void TextBackground(int color)
{
    LastMode = TextAttr;
    TextAttr = (color << 4) | (TextAttr & 0x0F);
    SetConsoleTextAttribute(hConsoleOutput, TextAttr);
}

void LowVideo()
{
    LastMode = TextAttr;
    TextAttr = TextAttr & 0xF7;
    SetConsoleTextAttribute(hConsoleOutput, TextAttr);
}

void HighVideo()
{
    LastMode = TextAttr;
    TextAttr = TextAttr | 0x08;
    SetConsoleTextAttribute(hConsoleOutput, TextAttr);
}

void NormVideo()
{
    LastMode = TextAttr;
    TextAttr = (unsigned char)StartAttr;
    SetConsoleTextAttribute(hConsoleOutput, TextAttr);
}


void FillerScreen(char fillChar)
{
    COORD coord;
    DWORD size, count;
    int y;
    coord.X = ConsoleScreenRect.Left;
    size = ConsoleScreenRect.Right - ConsoleScreenRect.Left + 1;
    for (y = ConsoleScreenRect.Top; y <= ConsoleScreenRect.Bottom; y++)
    {
        coord.Y = y;
        FillConsoleOutputAttribute(hConsoleOutput, TextAttr, size, coord, &count);
        FillConsoleOutputCharacter(hConsoleOutput, fillChar, size, coord, &count);
    }
    GotoXY(1, 1);
}

void FlushInputBuffer()
{
    FlushConsoleInputBuffer(hConsoleInput);
}

/*int GetCursor()
{
    CONSOLE_CURSOR_INFO cci;
    GetConsoleCursorInfo(hConsoleOutput, &cci);
    return cci.dwSize;
}

void SetCursor(int value)
{
    CONSOLE_CURSOR_INFO cci;
    if (value == 0)
    {
        cci.dwSize = GetCursor();
        cci.bVisible = false;
    }
    else
    {
        cci.dwSize = value;
        cci.bVisible = true;
    }
    SetConsoleCursorInfo(hConsoleOutput, &cci);
}*/

bool MousePressed()
{
    ULONGLONG currentTick = GetTickCount64();
    MousePressedButtons = 0;
    if (MouseButtonPressed)
    {
        int delta = (int)(currentTick - MouseEventTime);
        if (delta > 200)
        {
            MousePressedButtons = CONSOLE_MOUSE_LEFT_BUTTON;
            MouseButtonPressed = false;
            return true;
        }
    }
    return false;
}

void MouseGotoXY(int x, int y)
{
    mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_MOVE,
        x - 1, y - 1, WHEEL_DELTA, GetMessageExtraInfo());
    MousePosY = (y - 1) * MouseRowWidth;
    MousePosX = (x - 1) * MouseColWidth;
}

int MouseWhereX()
{
    return (MousePosX / MouseColWidth) + 1;
}

int MouseWhereY()
{
    return (MousePosY / MouseRowWidth) + 1;
}

void MouseShowCursor()
{
    DWORD mode;
    GetConsoleMode(hConsoleInput, &mode);
    if ((mode & ENABLE_MOUSE_INPUT) != ENABLE_MOUSE_INPUT)
    {
        mode |= ENABLE_MOUSE_INPUT;    
        SetConsoleMode(hConsoleInput, mode);
    }
}

void MouseHideCursor()
{
    DWORD mode;
    GetConsoleMode(hConsoleInput, &mode);
    if ((mode & ENABLE_MOUSE_INPUT) == ENABLE_MOUSE_INPUT)
    {
        mode |= ENABLE_MOUSE_INPUT;
        SetConsoleMode(hConsoleInput, mode);
    }
}

bool __stdcall ConsoleEventProc(DWORD ctrlType)
{
    return true;
}
#define INPUT_CONSOLE_MODE (ENABLE_WINDOW_INPUT | ENABLE_PROCESSED_INPUT | ENABLE_MOUSE_INPUT)
#define OUTPUT_CONSOLE_MODE (ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT)

void InitConsole()
{
    DWORD mode;
    COORD coord;
    CONSOLE_SCREEN_BUFFER_INFO cbi;
    //PtrOpenText : = TTextRec(Output).OpenFunc;
    //TTextRec(Input).Handle : = hConsoleInput;
    //Reset(Input);
    AllocConsole();
    hConsoleInput = GetStdHandle(STD_INPUT_HANDLE);
    AllocConsole();
    //ReWrite(Output);
    hConsoleOutput = GetStdHandle(STD_OUTPUT_HANDLE);
    //TTextRec(Output).Handle : = hConsoleOutput;
    GetConsoleMode(hConsoleInput, &mode);
    if ((mode & INPUT_CONSOLE_MODE) != INPUT_CONSOLE_MODE)
    {
        mode |= INPUT_CONSOLE_MODE;
        SetConsoleMode(hConsoleInput, mode);
    }
    //TTextRec(Output).InOutFunc : = @TextOut;
    //TTextRec(Output).FlushFunc : = @TextOut;
    GetConsoleScreenBufferInfo(hConsoleOutput, &cbi);
    GetConsoleMode(hConsoleOutput, &mode);
    if ((mode & OUTPUT_CONSOLE_MODE) != OUTPUT_CONSOLE_MODE)
    {
        mode |= OUTPUT_CONSOLE_MODE;
        SetConsoleMode(hConsoleOutput, mode);
    }
    TextAttr = (unsigned char)(cbi.wAttributes);
    StartAttr = cbi.wAttributes;
    LastMode = cbi.wAttributes;
    coord.X = cbi.srWindow.Left;
    coord.Y = cbi.srWindow.Top;
    WindowMin = (coord.Y << 8) | coord.X;
    coord.X = cbi.srWindow.Right;
    coord.Y = cbi.srWindow.Bottom;
    WindowMax = (coord.Y << 8) | coord.X;
    ConsoleScreenRect = cbi.srWindow;
    OldCodePage = (int)GetConsoleOutputCP();
    SetConsoleOutputCP(866);
    SetConsoleCtrlHandler((PHANDLER_ROUTINE) & ConsoleEventProc, true);
    SetCapture((HWND)hConsoleInput);
    KeyPressed();
    MouseColWidth = 1;
    MouseRowWidth = 1;
    MouseInstalled = true;
    Window(1, 1, 80, 25);
    ClrScr();
}

void DoneConsole()
{
    SetConsoleCtrlHandler((PHANDLER_ROUTINE) & ConsoleEventProc, false);
    SetConsoleOutputCP(OldCodePage);
    TextAttr = (unsigned char)StartAttr;
    SetConsoleTextAttribute(hConsoleOutput, TextAttr);
    ClrScr();
    FlushInputBuffer();
    //TTextRec(Input).Mode : = fmClosed;
    //TTextRec(Output).Mode : = fmClosed;
    FreeConsole();
}