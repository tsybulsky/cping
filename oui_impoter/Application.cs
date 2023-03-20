using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Security.Cryptography;
using System.Data.SqlTypes;
using System.Net.Sockets;
using System.Data.SQLite;

namespace oui_impoter
{
    internal class Application
    {
        private string _filename = "";
        public Application(string[] args) 
        {
            if (args.Length > 0)
            {
                _filename = args[0];
                if (!File.Exists(_filename)) 
                {
                    _filename = "";
                }
            }
        }

        private int StringToOid(string value)
        {
            int oid = 0;
            int i = 0;
            while (i < value.Length)
            {
                if (value[i] >= '0' && value[i] <= '9')
                {
                    oid = (oid << 4) | (value[i++] - 0x30);
                }
                else if (value[i] >= 'a' && value[i] <= 'f')
                {
                    oid = (oid << 4) | (value[i++] - 0x37);
                }
                else if (value[i] >= 'A' && value[i] <= 'F')
                {
                    oid = (oid << 4) | (value[i++] - 0x57);
                }
                if (i == 8)
                    break;
            }
            return oid;
        }
        public void Run()
        {
            if (String.IsNullOrEmpty(_filename))
            {
                while (true)
                {
                    Console.Write("Enter filename: ");
                    _filename = Console.ReadLine();
                    if (String.IsNullOrEmpty(Console.ReadLine()) ) 
                    { 
                        return; 
                    }
                    if (File.Exists(_filename) )
                    {
                        break;
                    }
                }
            }
            using (TextReader reader = new StreamReader(_filename))
            {
                #region Header reading
                string line;
                while((line = reader.ReadLine()) != null)
                {
                    if (String.IsNullOrEmpty(line))
                    {
                        break;
                    }
                }
                #endregion

                #region Reading data
                int rowNo = 0;
                int oid = 0;
                string manufacturerName = "";
                StringBuilder addressBuilder = new StringBuilder();
                string country = "";
                while (true)
                {
                    while ((line = reader.ReadLine()) != null)
                    {

                        if(String.IsNullOrEmpty(line))
                        {
                            break;
                        }
                        if (rowNo == 0)
                        {
                            int spaceIndex = line.IndexOf(' ');
                            //oid = StringToOid(line.Substring(0, spaceIndex - 1));
                            line = line.Substring(spaceIndex + 1).TrimStart();
                            spaceIndex = line.IndexOf(' ');
                            line = line.Substring(spaceIndex).TrimStart();
                            manufacturerName = line;
                            rowNo++;
                        }
                        else if (rowNo == 1)
                        {
                            int spaceIndex = line.IndexOf(' ');
                            oid = StringToOid(line.Substring(spaceIndex + 1));
                            rowNo++;
                        }
                        else
                        {
                           if (line.Length == 2)
                            {
                                country = line;
                            }
                           else
                            {
                                addressBuilder.Append(line);
                            }
                        }
                    }
                    string statement = "select rowId from countries where ";
                }
                #endregion
            }
        }


    }
}
