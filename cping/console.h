#ifndef __CONSOLE_H__
#define __CONSOLE_H__

#include <stdio.h>

#define CONSOLE_MODE_BW40		0
#define CONSOLE_MODE_CO40		1
#define CONSOLE_MODE_BW80		2
#define CONSOLE_MODE_CO80		3
#define CONSOLE_MODE_MONO		7
#define CONSOLE_FONT_8X8		256

#define CONSOLE_BLACK			0
#define CONSOLE_BLUE			1
#define CONSOLE_GREEN			2
#define CONSOLE_CYAN			CONSOLE_BLUE | CONSOLE_GREEN
#define CONSOLE_RED				4
#define CONSOLE_MAGENTA			CONSOLE_BLUE | CONSOLE_RED
#define CONSOLE_BROWN			CONSOLE_GREEN | CONSOLE_RED
#define CONSOLE_LIGHT_GRAY		CONSOLE_BLUE | CONSOLE_GREEN | CONSOLE_RED

#define CONSOLE_DARK_GRAY		8
#define CONSOLE_LIGHT_BLUE		CONSOLE_BLUE | CONSOLE_DARK_GRAY
#define CONSOLE_LIGHT_GREEN		CONSOLE_GREEN | CONSOLE_DARK_GRAY
#define CONSOLE_LIGNT_CYAN		CONSOLE_CYAN | CONSOLE_DARK_GRAY
#define CONSOLE_LIGHT_RED		CONSOLE_RED | CONSOLE_DARK_GRAY
#define CONSOLE_LIGHT_MAGENTA	CONSOLE_MAGENTA | CONSOLE_DARK_GRAY
#define CONSOLE_YELLOW			CONSOLE_BROWN | CONSOLE_DARK_GRAY
#define CONSOLE_WHITE			CONSOLE_LIGHT_GRAY | CONSOLE_DARK_GRAY

#define CONSOLE_MOUSE_LEFT_BUTTON	1
#define CONSOLE_MOUSE_RIGHT_BUTTON	2
#define CONSOLE_MOUSE_CENTER_BUTTON	4

extern int LastMode;
extern unsigned char TextAttr;
extern unsigned short WindowMin;
extern unsigned short WindowMax;
extern bool MouseInstalled;
extern unsigned short MousePressedButtons;

//void AssignCrt(FILE* file);
bool KeyPressed();
char ReadKey();
void TextMode(int mode);
void Window(int left, int top, int right, int bottom);
void GotoXY(int x, int y);
int WhereX();
int WhereY();
void ClrScr();
void ClrEol();
void InsLine();
void DelLine();
void TextColor(int color);
void TextBackground(int color);
void LowVideo();
void HighVideo();
void NormVideo();

void FillerScreen(char fillChar);
void FlushInputBuffer();
//int GetCursor();
//void SetCursor(int value);
bool MousePressed();
void MouseGotoXY(int x, int y);
int MouseWhereX();
int MouseWhereY();
void MouseShowCursor();
void MouseHideCursor();

void InitConsole();
void DoneConsole();
#endif // !__CONSOLE_H__