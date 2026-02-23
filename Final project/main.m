clear; close all; clc;

files = {'Signal01.wav', 'Signal02.wav', 'Signal03.wav', 'Signal04.wav', ...
         'Signal05.wav', 'Signal06.wav', 'Signal07.wav', 'Signal08.wav'};

note_names = {'C4', 'C#4/Db4', 'D4', 'D#4/Eb4', 'E4', 'F4','F#4/Gb4', ...
              'G4', 'G#4/Ab4', 'A4', 'A#4/Bb4', 'B4', 'C5'};
threshold_ratio = 0.5;
tolerance_Hz = 5;
T = table();

for k = 1:length(files)
    [xx, fs] = audioread(files{k});
    xx = xx .* hamming(length(xx));
   
    N = length(xx);
    X = abs(fft(xx));
    f = fs*(0:N-1)/N;
    [~, idx] = max(X(1:floor(N/2)));
    f_peak = f(idx);

    Q = round(f_peak / (2 * tolerance_Hz));
    
    [maxNote, energies] = toneDetect(xx, fs, Q);

    figure;
    bar(0:12, energies);
    xticks(0:12);
    xticklabels(note_names);
    xlabel('Note'); ylabel('Energy');
    title(sprintf('Energy Output for %s', files{k}));
    grid on;

    max_energy = max(energies);
    second_max = max(energies(energies < max_energy));
    avg_energy = mean(energies);

    f_min = 261.63;    % C4
    f_max = 523.25;    % C5
    
    out_of_range_by_freq = (f_peak < f_min || f_peak > f_max);
    out_of_range_by_energy = (max_energy < 3 * avg_energy || max_energy < 0.01);

    if out_of_range_by_freq && out_of_range_by_energy
    status = "Out-of-range";
    note_result = "-";
    elseif second_max / max_energy > threshold_ratio
        status = "Detuned";
        [~, idx] = max(energies);
        note_result = "Closer to " + note_names{idx};
    else
        status = "Match";
        note_result = note_names{maxNote+1};
    end

    T = [T; {files{k}, note_result , status}];
end

T.Properties.VariableNames = {'Signal', 'Result Type', 'Closest Note Justification'};
disp(T);