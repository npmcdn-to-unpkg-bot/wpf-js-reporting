using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace blablabla
{
    public abstract class iUO
    {
        protected Dictionary<string, string> _params = new Dictionary<string, string>();
        public string name { get; set; }
        public void addParam(string name, string value)
        {
            _params.Add(name, value);
        }
        public Dictionary<string, string> chooseParams(string[] choosen)
        {
            Dictionary<string, string> result = new Dictionary<string, string>();
            foreach(string i in choosen)
            {
                if(_params.ContainsKey(i))
                {
                    result.Add(i, _params[i]);
                }
            }
            return result;
        }

        public Dictionary<string, string> getAll()
        {
            return _params;
        }
    }
}
