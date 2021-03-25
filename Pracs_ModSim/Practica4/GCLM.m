function [nuevoZ, m] = GCLM(Z,tipo)
    switch tipo
        case 1 % -> Fishman-Moore
            m = (2^31)-1;
            a = 48271;
            c = 0;
            nuevoZ = mod((a*Z+c),m);
        case 2 % -> Kobayashi
            m = uint64(2^31);
            a = uint64(314159269);
            c = uint64(453806245);
            nuevoZ = double(mod((a*Z+c),m));
        case 3 % -> Coveyou-McPherson
            m = 2^35;
            a = 5^15;
            c = 1;
            nuevoZ = mod((a*Z+c),m);
        case 4 % -> glibc
            m = 2^31;
            a = 1103515245;
            c = 12345;
            nuevoZ = mod((a*Z+c),m);
        case 5 % -> MMIX
            m = 2^64;
            a = 6364136223846793005;
            c = 1442695040888963407;
            nuevoZ = mod((a*Z+c),m);
    end
end