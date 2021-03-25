using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using op; //Calculadora
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels.Http;
using System.Runtime.Remoting.Channels;

namespace Server
{
    class server
    {
        static void Main(string[] args)
        {
            //RemotingConfiguration.Configure("Server.exe.config");
            ChannelServices.RegisterChannel(new HttpChannel(8090));

            WellKnownServiceTypeEntry wkste =
               new WellKnownServiceTypeEntry(typeof(operaciones),
                                             "operaciones",
                                             WellKnownObjectMode.Singleton);

            RemotingConfiguration.RegisterWellKnownServiceType(wkste);
            Console.WriteLine("Server listo");
            Console.ReadLine();
        }
    }
}
