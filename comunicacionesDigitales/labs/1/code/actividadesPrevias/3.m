function plot_pam_instantaneo_signal()
    % Parámetros de la señal sinusoidal
    A = 1; % Amplitud
    fc = 1000; % Frecuencia en Hz

    % Parámetros iniciales de la modulación PAM
    fs_initial = 8000; % Frecuencia de muestreo inicial (Hz)
    d_initial = 0.5; % Ciclo de trabajo inicial

    % Crear la figura y los ejes
    fig = figure('Position', [100, 100, 800, 600]);
    ax = axes('Parent', fig, 'Position', [0.1, 0.2, 0.8, 0.7]);

    % Crear los sliders
    slider_fs = uicontrol('Parent', fig, 'Style', 'slider', ...
        'Position', [150, 60, 500, 20], ...
        'Min', 2000, 'Max', 20000, 'Value', fs_initial, ...
        'SliderStep', [0.001 0.01]);

    slider_d = uicontrol('Parent', fig, 'Style', 'slider', ...
        'Position', [150, 20, 500, 20], ...
        'Min', 0.1, 'Max', 0.9, 'Value', d_initial, ...
        'SliderStep', [0.01 0.1]);

    % Etiquetas para los sliders
    uicontrol('Parent', fig, 'Style', 'text', ...
        'Position', [150, 85, 200, 20], ...
        'String', 'Frecuencia de muestreo (fs):');

    uicontrol('Parent', fig, 'Style', 'text', ...
        'Position', [150, 45, 200, 20], ...
        'String', 'Ciclo de trabajo (d):');

    % Texto para mostrar los valores actuales
    fs_text = uicontrol('Parent', fig, 'Style', 'text', ...
        'Position', [660, 60, 100, 20]);

    d_text = uicontrol('Parent', fig, 'Style', 'text', ...
        'Position', [660, 20, 100, 20]);

    % Función para actualizar la gráfica
    function update_plot(~, ~)
        fs = round(slider_fs.Value);
        d = slider_d.Value;
        fs_text.String = sprintf('fs = %d Hz', fs);
        d_text.String = sprintf('d = %.2f', d);

        % Creación del vector de tiempo
        t = 0:1/100000:0.01; % Alta resolución para una representación suave

        % Generación de la señal sinusoidal
        m_t = A * sin(2*pi*fc*t);

        % Generación del reloj binario (onda cuadrada)
        reloj_binario = square(2 * pi * fs * t, d * 100);

        % Muestreo instantáneo
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

        % Actualizar la gráfica
        plot(ax, t, pam_instantaneo);
        xlabel(ax, 'Tiempo (s)');
        ylabel(ax, 'Amplitud');
        title(ax, 'Señal PAM con Muestreo Instantáneo');
        grid(ax, 'on');
    end

    % Asociar la función de actualización a los sliders
    slider_fs.Callback = @update_plot;
    slider_d.Callback = @update_plot;

    % Dibujar la gráfica inicial
    update_plot();
end

% Llamar a la función principal
plot_pam_instantaneo_signal();