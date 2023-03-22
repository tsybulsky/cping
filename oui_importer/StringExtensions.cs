using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace oui_importer
{
    public static class StringExtensions
    {
        public static string QuotedString(this string s, char quoteChar)
        {
            return s.Replace(new String(quoteChar, 1), new String(quoteChar, 2));
        }
    }
}
