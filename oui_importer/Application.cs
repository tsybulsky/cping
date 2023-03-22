using System;
using System.Text;
using System.IO;
using Microsoft.Data.Sqlite;
using System.Reflection;
using System.Data;
using SQLitePCL;
using oui_importer;

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
                    oid = (oid << 4) | (value[i++] - 0x57);
                }
                else if (value[i] >= 'A' && value[i] <= 'F')
                {
                    oid = (oid << 4) | (value[i++] - 0x37);
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
            string statement = "";
            try
            {
                if (_connection == null)
                    return -1;
                int countryId = 0;
                
                SqliteCommand command = _connection.CreateCommand();
                statement = $"select Id from countries where A2 = '{country}'";
                command.CommandText = statement;
                using (SqliteDataReader reader = command.ExecuteReader())
                {
                    if ((!reader.Read()) || ((countryId = reader.GetInt32(0)) == 0))
                    {
                        Console.WriteLine($"Cannot get country id for {country}");
                        return -1;
                    }                    
                }
                statement = "insert into manufacturers (NameEn, NameRu, Address, Country) values " +
                                      $"('{manufacturerName}', '{manufacturerName}', '{manufacturerAddress.QuotedString('\'')}', {countryId}) " +
                                      "returning Id";
                command.CommandText = statement;
                using (SqliteDataReader reader = command.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        Console.WriteLine(statement);
                        Console.WriteLine();
                        return -1;
                    }
                    return reader.GetInt32(0);
                }
            }
            catch ( Exception ex)
            {
                Console.WriteLine(statement);
                Console.WriteLine(ex.Message);
                Console.WriteLine($"Cannot insert manufacturer {manufacturerName} {country}");
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
            int inserted = 0;
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
                while ((line = reader.ReadLine()) != null)
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
                    rowNo = 0;
                    addressBuilder.Clear();
                    country = "";
                    manufacturerName = "";
                    manufacturerId = -1;
                    oid = 0;
                    while ((line = reader.ReadLine()) != null)
                    {

                        if (String.IsNullOrEmpty(line))
                        {
                            rowNo = 0;
                            break;
                        }
                        line = line.Trim();
                        if (rowNo == 0)
                        {
                            int spaceIndex = line.IndexOf(' ');
                            //oid = StringToOid(line.Substring(0, spaceIndex - 1));
                            line = line.Substring(spaceIndex + 1).TrimStart();
                            spaceIndex = line.IndexOfAny(new char[]{' ', '\t'});
                            line = line.Substring(spaceIndex).TrimStart();
                            manufacturerName = line.QuotedString('\'');
                            rowNo++;
                        }
                        else if (rowNo == 1)
                        {
                            int spaceIndex = line.IndexOf(' ');
                            oid = StringToOid(line.Substring(0, spaceIndex + 1));
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
                    if (line == null)
                        break;
                    string statement;
                    statement = $"select Id from Manufacturers where NameEn = '{manufacturerName}'";
                    SqliteCommand command = _connection.CreateCommand();
                    command.CommandText = statement;
                    using (SqliteDataReader dbReader = command.ExecuteReader())
                    {
                        if ((!dbReader.Read())||((manufacturerId = dbReader.GetInt32(0)) == 0))
                        {
                            manufacturerId = InsertManufacturer(manufacturerName, addressBuilder.ToString(), country);
                            if (manufacturerId == 0)
                            {
                                Console.WriteLine($"Manufacturer {manufacturerName} not created!");
                                continue;
                            }
                        }
                    }
                    int id = 0;
                    command.CommandText = $"select id from ouis where (Mask = {oid}) and (Manufacturer = {manufacturerId})";
                    
                    using (SqliteDataReader dbReader = command.ExecuteReader())
                    {
                        SqliteCommand updateCommand = _connection.CreateCommand();
                        if ((!dbReader.Read()) || ((id = dbReader.GetInt32(0)) == 0))
                        {
                            updateCommand.CommandText = "insert into ouis (Mask, Manufacturer) values " +
                                $"({oid},{manufacturerId})";
                            try
                            {
                                updateCommand.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message ); 
                                Console.WriteLine($"{oid:X6} {manufacturerId,-7} {manufacturerName}");
                            }
                            inserted++;                            
                        }                        
                    }                          
                }
                #endregion
            }
        }
    }
}
