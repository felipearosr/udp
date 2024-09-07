function plot_sinusoidal_signal()
    % Parámetros iniciales de la señal
    A = 1; % Amplitud
    fc = 1000; % Frecuencia en Hz
    fs_initial = 100000; % Frecuencia de muestreo inicial (muestras por segundo)

    % Crear la figura y los ejes
    fig = figure('Position', [100, 100, 800, 600]);
    ax = axes('Parent', fig, 'Position', [0.1, 0.2, 0.8, 0.7]);

    % Crear el slider
    slider = uicontrol('Parent', fig, 'Style', 'slider', ...
        'Position', [150, 30, 500, 20], ...
        'Min', 2000, 'Max', 200000, 'Value', fs_initial, ...
        'SliderStep', [0.001 0.01]);

    % Etiqueta para el slider
    uicontrol('Parent', fig, 'Style', 'text', ...
        'Position', [150, 55, 100, 20], ...
        'String', 'Frecuencia de muestreo (fs):');

    % Texto para mostrar el valor actual de fs
    fs_text = uicontrol('Parent', fig, 'Style', 'text', ...
        'Position', [660, 30, 100, 20]);

    % Función para actualizar la gráfica
    function update_plot(~, ~)
        fs = round(slider.Value);
        fs_text.String = sprintf('fs = %d Hz', fs);

        % Creación del vector de tiempo
        t = 0:1/fs:0.01; % Desde 0 hasta 0.01 segundos con pasos de 1/fs

        % Generación de la señal sinusoidal
        m_t = A * sin(2*pi*fc*t);

        % Actualizar la gráfica
        plot(ax, t, m_t);
        xlabel(ax, 'Tiempo (s)');
        ylabel(ax, 'Amplitud');
        title(ax, 'Señal sinusoidal m(t)');
        grid(ax, 'on');
    end

    % Asociar la función de actualización al slider
    slider.Callback = @update_plot;

    % Dibujar la gráfica inicial
    update_plot();
end

% Llamar a la función principal
plot_sinusoidal_signal();