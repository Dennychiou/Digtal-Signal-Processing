function [maxNote, energies] = toneDetect(xx, ~, Q)

    fs = 8000; 
    f0 = 261.63;
    maxPow = 0;
    maxNote = -1;
    all = xx';

    for note = 0:12
        freq = f0 * 2^(note/12);
        bw = freq / Q;
        [b, a] = iirpeak(freq / (fs/2), bw / (fs/2));
        yy = filter(b, a, xx);
        pow = sum(yy.^2);
        energies(note+1) = pow;

        if pow > maxPow
            maxPow = pow;
            maxNote = note;
        end
    end
end
