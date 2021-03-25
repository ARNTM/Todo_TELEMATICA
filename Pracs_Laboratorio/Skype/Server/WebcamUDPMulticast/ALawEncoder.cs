using System;
using System.Collections.Generic;
using System.Text;

namespace ALaw
{
    
    public class ALawEncoder
    {
        public const int MAX = 0x7fff; 

        
        private static byte[] pcmToALawMap;

        static ALawEncoder()
        {
            pcmToALawMap = new byte[65536];
            for (int i = short.MinValue; i <= short.MaxValue; i++)
                pcmToALawMap[(i & 0xffff)] = encode(i);
        }

        
        private static byte encode(int pcm)
        {
            
            int sign = (pcm & 0x8000) >> 8;
            
            if (sign != 0)
                pcm = -pcm;
            
            if (pcm > MAX) pcm = MAX;

           
            int exponent = 7;
            
            for (int expMask = 0x4000; (pcm & expMask) == 0 && exponent>0; exponent--, expMask >>= 1) { }

           
            int mantissa = (pcm >> ((exponent == 0) ? 4 : (exponent + 3))) & 0x0f;

            
            byte alaw = (byte)(sign | exponent << 4 | mantissa);

           
            return (byte)(alaw^0xD5);
        }

       
        public static byte ALawEncode(int pcm)
        {
            return pcmToALawMap[pcm & 0xffff];
        }

        
        public static byte ALawEncode(short pcm)
        {
            return pcmToALawMap[pcm & 0xffff];
        }

       
        public static byte[] ALawEncode(int[] data)
        {
            int size = data.Length;
            byte[] encoded = new byte[size];
            for (int i = 0; i < size; i++)
                encoded[i] = ALawEncode(data[i]);
            return encoded;
        }

       
        public static byte[] ALawEncode(short[] data)
        {
            int size = data.Length;
            byte[] encoded = new byte[size];
            for (int i = 0; i < size; i++)
                encoded[i] = ALawEncode(data[i]);
            return encoded;
        }

      
        public static byte[] ALawEncode(byte[] data)
        {
            int size = data.Length / 2;
            byte[] encoded = new byte[size];
            for (int i = 0; i < size; i++)
                encoded[i] = ALawEncode((data[2 * i + 1] << 8) | data[2 * i]);
            return encoded;
        }

        
        public static void ALawEncode(byte[] data, byte[] target)
        {
            int size = data.Length / 2;
            for (int i = 0; i < size; i++)
                target[i] = ALawEncode((data[2 * i + 1] << 8) | data[2 * i]);
        }
    }
}
