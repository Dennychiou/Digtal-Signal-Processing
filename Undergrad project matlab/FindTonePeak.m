[xx, fs] = audioread('SunshineSquare.wav');
xx = xx';
figure(1)
specgram(xx, [], fs)


N = length(xx);
X = fft(xx);
X_mag = abs(X(1:floor(N/2)));  
f_axis = (0:floor(N/2)-1) * fs / N;


search_ranges = [1570 1620; 
                 3120 3170; 
                 4710 4760];

peak_freqs = zeros(1, size(search_ranges, 1));

for i = 1:size(search_ranges, 1)
    idx = find(f_axis >= search_ranges(i, 1) & f_axis <= search_ranges(i, 2));
    [~, max_idx] = max(X_mag(idx));
    peak_freqs(i) = f_axis(idx(max_idx));     
end

format long
disp('peak freqs ：');
disp(peak_freqs);