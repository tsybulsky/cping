using System;
using System.Text;
using System.IO;
using Microsoft.Data.Sqlite;
using System.Reflection;

namespace oui_impoter
{
    internal class Application
    {
        private string _filename = "";
        private SqliteConnection? _connection;
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

        private static int StringToOid(string value)
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
                else 
                    i++;
                if (i == 8)
                    break;
            }
            return oid;
        }

        private int InsertManufacturer(string manufacturerName, string manufacturerAddress, string country)
        {
            try
            {
                if (_connection == null)
                    return -1;
                int countryId = 0;
                SqliteCommand command = _connection.CreateCommand();
                command.CommandText = $"select Id from countries where code = '{country}'";
                using (SqliteDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                        return -1;
                    countryId = reader.GetInt32(0);
                }
                command.CommandText = "insert into manufacturers (NameEn, NameRu, Address, Country) values " +
                                      $"('{manufacturerName}', '{manufacturerName}', '{manufacturerAddress}', {countryId}) "+
                                      "returning Id";
                using (SqliteDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                        return -1;
                    return reader.GetInt32(0);
                }
            }
            catch
            {
                return -1;
            }
        }

        public void Run()
        {
            
            if (String.IsNullOrEmpty(_filename))
            {
                while (true)
                {
                    Console.Write("Enter filename: ");
                    _filename = Console.ReadLine();
                    if (String.IsNullOrEmpty(_filename) ) 
                    { 
                        return; 
                    }
                    if (File.Exists(_filename) )
                    {
                        break;
                    }
                }
            }
            //string dbPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase);
            SqliteConnectionStringBuilder builder = new SqliteConnectionStringBuilder
            {

                DataSource = "oui.db3"// Path.Combine(dbPath, "oui.db3")
            };
            _connection = new SqliteConnection(builder.ConnectionString);
            _connection.Open();
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
                int manufacturerId = 0;
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
                            oid = StringToOid(line.Substring(0,spaceIndex + 1));
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
                    string statement;
                    statement = $"select Id from Manufacturers where NameEn = '{manufacturerName}'";
                    SqliteCommand command = _connection.CreateCommand();
                    command.CommandText = statement;
                    using (SqliteDataReader dbReader = command.ExecuteReader())
                    {
                        if (!dbReader.Read())
                        {
                            manufacturerId = InsertManufacturer(manufacturerName, addressBuilder.ToString(), country);
                        }
                        else
                        {
                            manufacturerId = dbReader.GetInt32(0);
                        }
                    }
                    command.CommandText = "insert into oui (Mask, Manufacturer) values "+
                        $"({oid},{manufacturerId})";
                    command.ExecuteNonQuery();
                }
                #endregion
            }
        }
    }
}
