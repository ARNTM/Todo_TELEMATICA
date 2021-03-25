using System;
using System.Collections.Generic;
using System.Text;

namespace Ejercicio2
{
    class ordenar
    {
        public void creciente(int[] n) {
            for (int i=0 ; i<n.Length ; i++) {
                for (int j=0 ; j<i ; j++) {
                    if (n[i]<n[j]) {
                        int aux = n[j];
                        n[j] = n[i];
                        n[i] = aux;
                    }
                }
            }
        }

        public void decreciente(int[] n) {
            for (int i = 0; i < n.Length; i++){
                for (int j = 0; j < i; j++){
                    if (n[i]>n[j]){
                        int aux = n[j];
                        n[j] = n[i];
                        n[i] = aux;
                    }
                }
            }
        }
    }
}
