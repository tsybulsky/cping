// sqlite_test.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include "sqlite3.h"

bool str2oid(char*, int*);

int main()
{
    sqlite3* connection;
    if (sqlite3_open("oui.db3", &connection) != SQLITE_OK)
    {
        std::cout << "Cannot open oui.db3 database file\n";
        return -1;
    }
    while (true)
    {
        std::cout << "Enter oid: ";
        char* line = new char[80];
        std::cin >> line;
        if (line == "")
        {
            sqlite3_close(connection);
            return 0;
        }
        int oid;
        if (!str2oid(line, &oid))
        {
            std::cout << "Invalid oid string\n";
            sqlite3_close(connection);
            getchar();
            continue;
        }

        char* statement = new char[1024];
        sprintf_s(statement, 1024, "select m.NameEn, c.NameEn, c.A3 from ouis o inner join manufacturers m on o.manufacturer = m.Id inner join countries c on m.country = c.Id where o.Mask = %d",
            oid);
        sqlite3_stmt *pstmt;
        if (sqlite3_prepare(connection, statement, 1024, &pstmt, NULL) != SQLITE_OK)
        {
            std::cout << sqlite3_errmsg(connection) << "\n";
            continue;
        }
        int code;
        while ((code = sqlite3_step(pstmt)) != SQLITE_ERROR)
        {
            switch (code)
            {
            case SQLITE_DONE:
            {
                sqlite3_close(connection);
                getchar();
                return 0;
            }
            case SQLITE_ROW:
            {
                int textSize, totalArgsSize = 0;
                char* manufacturerName;
                char* countryName;
                char* countryA3;
                textSize = (sqlite3_column_bytes(pstmt, 0));
                totalArgsSize += textSize;
                manufacturerName = new char[textSize];
                manufacturerName = (char*)sqlite3_column_text(pstmt, 0);
                countryName = (char*)sqlite3_column_text(pstmt, 1);
                countryA3 = (char*)sqlite3_column_text(pstmt, 2);
                std::cout << manufacturerName << ", " << countryName << " (" << countryA3 << ")\n";
                
                break;
            }
            }
        }
        sqlite3_finalize(pstmt);
    }
    getchar();
    sqlite3_close(connection);
    return 0;
}

bool str2oid(char* str, int* oid)
{
    *oid = 0;
    int i = 0;
    char* p = str;
    while ((*p != NULL)&&(i < 8))
    {
        if ((*p >= '0') && (*p <= '9'))
        {
            *oid = (*oid << 4) | (*p - 0x30);
        }
        else if ((*p >= 'A') && (*p <= 'F'))
        {
            *oid = (*oid << 4) | (*p - 0x37);
        }
        else if ((*p >= 'a') && (*p <= 'f'))
        {
            *oid = (*oid << 4) | (*p - 0x57);
        }
        else if (!((*p != '-') && (*p != ':')))
            return false;
        p++; i++;
    }
    return true;
}
// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.
