% Parámetros de la señal original
A = 1; % Amplitud
fc = 1000; % Frecuencia de la señal original en Hz
fs = 100000; % Frecuencia de muestreo de la señal original en Hz
t = 0:1/fs:0.01; % Tiempo de 10 ms con intervalo de muestreo de 10 µs
m_t = A * sin(2 * pi * fc * t); % Señal sinusoidal original

% Parámetros de muestreo
fs_muestreo = 8000; % Frecuencia de muestreo del reloj en Hz
d = 0.5; % Ciclo de trabajo del reloj (50% en este caso)

% Generación del reloj binario (onda cuadrada)
reloj_binario = square(2 * pi * fs_muestreo * t, d * 100);

% Muestreo natural: Multiplicación de la señal original por el reloj binario
pam_natural = m_t .* (reloj_binario > 0);

% Muestreo instantáneo: Se toma la señal solo en los puntos de muestreo
pam_instantaneo = zeros(size(t));
indices = find(diff([0 reloj_binario]) > 0);
for i = 1:length(indices)
    if i < length(indices)
        pam_instantaneo(indices(i):indices(i+1)-1) = m_t(indices(i));
    else
        pam_instantaneo(indices(i):end) = m_t(indices(i));
    end
end

pam_instantaneo = pam_instantaneo .* (reloj_binario > 0);


% Gráfica de la señal original
figure;

subplot(3,1,1);
plot(t, m_t, 'b');
title('Señal Original m(t)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Gráfica de la señal PAM con muestreo natural
subplot(3,1,2);
plot(t, pam_natural, 'r');
title('Señal PAM con Muestreo Natural');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Gráfica de la señal PAM con muestreo instantáneo
subplot(3,1,3);
plot(t, pam_instantaneo, 'g');
title('Señal PAM con Muestreo Instantáneo');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;