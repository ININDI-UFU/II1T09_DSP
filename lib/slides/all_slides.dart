import 'package:flutter/material.dart';
import '../widgets/slide_template.dart';

Widget buildSlide(int index) {
  switch (index) {
    case 0:
      return const TitleSlide(
        key: ValueKey(0),
        title: 'Processamento Digital\nde Sinais na ESP32',
        subtitle:
            'Filtros Digitais e FFT\n\nFIR, IIR, EMA e Análise Espectral\nAula 15 • Sistemas Embarcados',
        chip: 'DSP',
        accentColor: Color(0xFF6C5CE7),
      );
    case 1:
      return CardsSlide(
        key: const ValueKey(1),
        title: 'Agenda',
        subtitle: 'Conteúdo da aula',
        accentColor: const Color(0xFF6C5CE7),
        cards: const [
          InfoCardData(
            title: '01. Fundamentos',
            description: 'O que é DSP e por que usar',
            icon: Icons.school_rounded,
            color: Color(0xFF6C5CE7),
          ),
          InfoCardData(
            title: '02. Aquisição',
            description: 'Amostragem, quantização e Nyquist',
            icon: Icons.input_rounded,
            color: Color(0xFF55EFC4),
          ),
          InfoCardData(
            title: '03. Filtros FIR',
            description: 'Finite Impulse Response — média móvel',
            icon: Icons.filter_alt_rounded,
            color: Color(0xFF74B9FF),
          ),
          InfoCardData(
            title: '04. Filtros IIR',
            description: 'Infinite Impulse Response — recursivos',
            icon: Icons.loop_rounded,
            color: Color(0xFF6C5CE7),
          ),
          InfoCardData(
            title: '05. EMA',
            description: 'Exponential Moving Average — filtro prático',
            icon: Icons.trending_up_rounded,
            color: Color(0xFF55EFC4),
          ),
          InfoCardData(
            title: '06. FFT',
            description: 'Fast Fourier Transform — análise espectral',
            icon: Icons.graphic_eq_rounded,
            color: Color(0xFF74B9FF),
          ),
          InfoCardData(
            title: '07. Aplicações',
            description: 'Projetos reais com DSP na ESP32',
            icon: Icons.devices_rounded,
            color: Color(0xFF6C5CE7),
          ),
        ],
        crossAxisCount: 4,
      );
    case 2:
      return ContentSlide(
        key: const ValueKey(2),
        title: 'O que é DSP?',
        subtitle: 'Digital Signal Processing — Conceitos',
        accentColor: const Color(0xFF6C5CE7),
        items: const [
          ContentItem(
            text: 'DSP: processamento matemático de sinais digitalizados',
            icon: Icons.analytics_rounded,
            iconColor: Color(0xFF6C5CE7),
            isBold: true,
          ),
          ContentItem(
            text: 'Cadeia: Sinal Analógico → ADC → DSP → DAC → Sinal Analógico',
            icon: Icons.arrow_forward_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text:
                'Vantagens: precisão, repetibilidade, adaptabilidade, sem drift térmico',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text:
                'Filtrar ruído, extrair informação, detectar frequências, comprimir',
            icon: Icons.tune_rounded,
          ),
          ContentItem(
            text: 'Na ESP32: processamento em tempo real com 240 MHz dual-core',
            icon: Icons.memory_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text:
                'Limitação: velocidade limitada pelo ADC (~20 ksps com analogRead)',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
        ],
      );
    case 3:
      return ContentSlide(
        key: const ValueKey(3),
        title: 'Domínio do Tempo vs Frequência',
        subtitle: 'Duas formas de analisar o mesmo sinal',
        accentColor: const Color(0xFF55EFC4),
        items: const [
          ContentItem(
            text: 'Domínio do Tempo: amplitude x(t) ao longo do tempo',
            icon: Icons.timeline_rounded,
            iconColor: Color(0xFF6C5CE7),
            isBold: true,
          ),
          ContentItem(
            text:
                'Domínio da Frequência: quais frequências estão presentes e suas amplitudes',
            icon: Icons.graphic_eq_rounded,
            iconColor: Color(0xFF55EFC4),
            isBold: true,
          ),
          ContentItem(
            text: 'Transformada de Fourier: converte tempo → frequência',
            icon: Icons.transform_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'Exemplo: nota dó (262 Hz) → pico em 262 Hz no espectro',
            icon: Icons.music_note_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Sinal com ruído: ruído em alta frequência → filtrável',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'FFT: Fast Fourier Transform — versão eficiente (O(N log N))',
            icon: Icons.speed_rounded,
          ),
        ],
      );
    case 4:
      return const SectionTitleSlide(
        key: ValueKey(4),
        sectionNumber: '01',
        title: 'Aquisição de Sinais',
        subtitle:
            'Amostragem, quantização e aliasing\nTeorema de Nyquist na prática',
        accentColor: Color(0xFF55EFC4),
        icon: Icons.input_rounded,
      );
    case 5:
      return ContentSlide(
        key: const ValueKey(5),
        title: 'Amostragem e Quantização',
        subtitle: 'Convertendo o mundo analógico em digital',
        accentColor: const Color(0xFF55EFC4),
        items: const [
          ContentItem(
            text:
                'Amostragem: medir o valor do sinal em intervalos regulares (Ts = 1/Fs)',
            icon: Icons.grid_on_rounded,
            iconColor: Color(0xFF55EFC4),
            isBold: true,
          ),
          ContentItem(
            text:
                'Quantização: arredondar para o nível discreto mais próximo (n bits)',
            icon: Icons.stacked_bar_chart_rounded,
            iconColor: Color(0xFF6C5CE7),
            isBold: true,
          ),
          ContentItem(
            text: 'Nyquist: Fs ≥ 2 × fmax para evitar aliasing',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
          ContentItem(
            text: 'Na prática: Fs ≈ 5–10 × fmax para boa representação',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'ESP32 ADC: 12 bits = 4096 níveis, attenuation 11dB = 0–3.3V',
            icon: Icons.memory_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'analogRead: ~20 ksps max → fmax ≈ 10 kHz (sem I2S)',
            icon: Icons.speed_rounded,
          ),
          ContentItem(
            text: 'I2S ADC: até 150 ksps com DMA (sem bloquear CPU)',
            icon: Icons.bolt_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
        ],
      );
    case 6:
      return ContentSlide(
        key: const ValueKey(6),
        title: 'Aliasing — O Inimigo',
        subtitle: 'O que acontece quando sub-amostramos',
        accentColor: const Color(0xFFFF6B6B),
        items: const [
          ContentItem(
            text:
                'Aliasing: frequências acima de Fs/2 "disfarçam-se" de frequências baixas',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFFF6B6B),
            isBold: true,
          ),
          ContentItem(
            text:
                'Exemplo: sinal de 8 kHz amostrado a 10 kHz → aparece como 2 kHz',
            icon: Icons.shuffle_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text:
                'Frequência de Nyquist: fN = Fs/2 — limite máximo representável',
            icon: Icons.vertical_align_top_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Solução: filtro anti-aliasing (RC passa-baixa) ANTES do ADC',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text:
                'fc do filtro ≈ fN = Fs/2 — corta frequências que causariam aliasing',
            icon: Icons.content_cut_rounded,
          ),
          ContentItem(
            text:
                'Fs = 10 kHz → anti-aliasing com fc ≈ 5 kHz → R=330Ω, C=100nF',
            icon: Icons.calculate_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text:
                'Oversampling: amostrar muito mais rápido relaxa o filtro anti-aliasing',
            icon: Icons.layers_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
        ],
      );
    case 7:
      return const SectionTitleSlide(
        key: ValueKey(7),
        sectionNumber: '02',
        title: 'Filtros Digitais — FIR',
        subtitle: 'Finite Impulse Response\nMédia Móvel e Convolução',
        accentColor: Color(0xFF74B9FF),
        icon: Icons.filter_alt_rounded,
      );
    case 8:
      return ContentSlide(
        key: const ValueKey(8),
        title: 'FIR — Conceito',
        subtitle: 'Filtro de Resposta ao Impulso Finita',
        accentColor: const Color(0xFF74B9FF),
        items: const [
          ContentItem(
            text: 'y[n] = Σ h[k] × x[n-k] para k = 0 a M-1',
            icon: Icons.functions_rounded,
            iconColor: Color(0xFF74B9FF),
            isBold: true,
          ),
          ContentItem(
            text:
                'Saída depende apenas de entradas atuais e passadas (sem feedback)',
            icon: Icons.arrow_forward_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'Sempre estável (não pode oscilar)',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'Fase linear possível (importante para áudio e comunicações)',
            icon: Icons.linear_scale_rounded,
          ),
          ContentItem(
            text: 'Requer mais coeficientes (M) que IIR para mesma atenuação',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Média Móvel: caso especial onde todos os h[k] = 1/M',
            icon: Icons.drag_handle_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Complexidade: M multiplicações + M-1 somas por amostra',
            icon: Icons.calculate_rounded,
          ),
        ],
      );
    case 9:
      return ContentSlide(
        key: const ValueKey(9),
        title: 'Média Móvel — Filtro FIR Simples',
        subtitle: 'O filtro digital mais usado em sensores',
        accentColor: const Color(0xFF74B9FF),
        items: const [
          ContentItem(
            text: 'y[n] = (1/M) × Σ x[n-k] para k = 0 a M-1',
            icon: Icons.calculate_rounded,
            iconColor: Color(0xFF74B9FF),
            isBold: true,
          ),
          ContentItem(
            text: 'M = número de amostras na janela (ordem do filtro)',
            icon: Icons.tune_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'M grande: mais suavização, mais atraso',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'M pequeno: menos suavização, resposta mais rápida',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'fc ≈ Fs / (2π × M) — frequência de corte aproximada',
            icon: Icons.show_chart_rounded,
          ),
          ContentItem(
            text: 'Implementação eficiente: buffer circular + soma running',
            icon: Icons.loop_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text:
                'Ideal para: leitura de sensores, suavização de ADC, temperatura',
            icon: Icons.thermostat_rounded,
          ),
        ],
      );
    case 10:
      return const CodeSlide(
        key: ValueKey(10),
        title: 'Média Móvel — Código',
        subtitle: 'ESP32 • Buffer circular • O(1) por amostra',
        accentColor: Color(0xFF74B9FF),
        code: '''#define M 16  // potência de 2
#define MASK (M - 1)

int16_t buf[M] = {0};
int32_t soma = 0;
uint8_t idx = 0;

int16_t mediaMovel(int16_t x) {
  soma -= buf[idx];       // remove antigo
  buf[idx] = x;           // insere novo
  soma += x;              // atualiza soma
  idx = (idx + 1) & MASK; // incrementa circular
  return (int16_t)(soma >> 4); // soma/16 por shift
}

void loop() {
  int raw = analogRead(34);
  int filtrado = mediaMovel(raw);
  Serial.printf("%d,%d\\n", raw, filtrado);
  delayMicroseconds(100);
}''',
        explanationPoints: [
          'Buffer circular de tamanho M (potência de 2)',
          'Remove amostra antiga, adiciona nova → O(1)',
          'Divisão por shift (>>4 = /16) para M=16',
          'MASK evita operação de módulo (mais rápido)',
          'Zero inicialização para transiente suave',
          'Saída suavizada com atraso de M/2 amostras',
        ],
      );
    case 11:
      return const SectionTitleSlide(
        key: ValueKey(11),
        sectionNumber: '03',
        title: 'Filtros IIR',
        subtitle:
            'Infinite Impulse Response\nRecursivos • Eficientes • Cuidado com estabilidade',
        accentColor: Color(0xFF6C5CE7),
        icon: Icons.loop_rounded,
      );
    case 12:
      return ContentSlide(
        key: const ValueKey(12),
        title: 'IIR — Conceito',
        subtitle: 'Filtro de Resposta ao Impulso Infinita',
        accentColor: const Color(0xFF6C5CE7),
        items: const [
          ContentItem(
            text: 'y[n] = Σ b[k]×x[n-k] − Σ a[k]×y[n-k]',
            icon: Icons.functions_rounded,
            iconColor: Color(0xFF6C5CE7),
            isBold: true,
          ),
          ContentItem(
            text: 'Saída depende de entradas E saídas anteriores (feedback)',
            icon: Icons.loop_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text:
                'Muito eficiente: poucos coeficientes para atenuação profunda',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text:
                'Pode ser instável se coeficientes incorretos (polos fora do círculo)',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
          ContentItem(
            text: 'Tipos clássicos: Butterworth, Chebyshev, Bessel, Elliptic',
            icon: Icons.category_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text:
                'Butterworth: resposta mais plana na banda passante (mais usado)',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Implementação digital: seção biquad (2ª ordem) em cascata',
            icon: Icons.layers_rounded,
          ),
        ],
      );
    case 13:
      return ComparisonSlide(
        key: const ValueKey(13),
        title: 'FIR vs IIR — Quando Usar',
        accentColor: const Color(0xFF6C5CE7),
        headers: const ['Critério', 'FIR', 'IIR'],
        rows: const [
          ['Estabilidade', 'Sempre estável', 'Pode ser instável'],
          ['Fase', 'Linear possível', 'Não-linear'],
          ['Coeficientes', 'Muitos (M grande)', 'Poucos (eficiente)'],
          ['Complexidade', 'M mult + M-1 soma', '4-6 mult + somas'],
          ['Memória', 'M amostras armazenadas', 'Poucos estados'],
          ['Latência', 'M/2 amostras', 'Muito baixa'],
          ['Transiente', 'Finito (M amostras)', 'Infinito (decai)'],
          ['Design', 'Window, Parks-McClellan', 'Bilinear transform'],
          ['Uso típico', 'Áudio, comunicações', 'Sensores, controle'],
        ],
      );
    case 14:
      return const SectionTitleSlide(
        key: ValueKey(14),
        sectionNumber: '04',
        title: 'EMA — Exponential\nMoving Average',
        subtitle:
            'O filtro digital mais prático para embarcados\ny[n] = α·x[n] + (1−α)·y[n−1]',
        accentColor: Color(0xFF55EFC4),
        icon: Icons.trending_up_rounded,
      );
    case 15:
      return ContentSlide(
        key: const ValueKey(15),
        title: 'EMA — Conceito',
        subtitle: 'Filtro IIR de 1ª ordem com 1 coeficiente',
        accentColor: const Color(0xFF55EFC4),
        items: const [
          ContentItem(
            text: 'y[n] = α·x[n] + (1−α)·y[n−1]',
            icon: Icons.functions_rounded,
            iconColor: Color(0xFF55EFC4),
            isBold: true,
          ),
          ContentItem(
            text: 'α (alpha): fator de suavização, 0 < α ≤ 1',
            icon: Icons.tune_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'α → 0: muita suavização, resposta lenta',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'α → 1: pouca suavização, resposta rápida (y ≈ x)',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'fc ≈ α × Fs / (2π) — frequência de corte',
            icon: Icons.calculate_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'Equivale a IIR de 1ª ordem: b=[α], a=[1, -(1-α)]',
            icon: Icons.code_rounded,
          ),
          ContentItem(
            text: 'Simples, rápido, apenas 1 variável de estado (y anterior)',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
        ],
      );
    case 16:
      return const CodeSlide(
        key: ValueKey(16),
        title: 'EMA — Código',
        subtitle: 'ESP32 • Filtro digital de 1 linha',
        accentColor: Color(0xFF55EFC4),
        code: '''#include <Arduino.h>

#define ADC_PIN 34

float alpha = 0.1;  // suavização forte
float filtrado = 0;

float ema(float novaAmostra) {
  filtrado = alpha * novaAmostra
           + (1.0 - alpha) * filtrado;
  return filtrado;
}

void setup() {
  Serial.begin(115200);
  filtrado = analogRead(ADC_PIN);  // inicializa
}

void loop() {
  float raw = analogRead(ADC_PIN);
  float suave = ema(raw);
  Serial.printf("%.0f,%.1f\\n", raw, suave);
  delayMicroseconds(100);  // Fs = 10 kHz
}''',
        explanationPoints: [
          'α = 0.1 → corta freq acima de ~160 Hz (Fs=10kHz)',
          'y = α·x + (1-α)·y — uma única multiplicação e soma',
          'Inicializar filtrado com primeira amostra (evita transiente)',
          'Ajustar α para compromisso filtragem/velocidade',
          'α=0.01: muito suave (1.6 Hz), α=0.5: pouca filtragem (800 Hz)',
          'CSV no Serial: plotar com Serial Plotter do Arduino IDE',
        ],
      );
    case 17:
      return ContentSlide(
        key: const ValueKey(17),
        title: 'EMA — Escolhendo Alpha',
        subtitle: 'Guia prático para configuração',
        accentColor: const Color(0xFF55EFC4),
        items: const [
          ContentItem(
            text: 'α = 2 / (N+1) — equivale a média móvel de N amostras',
            icon: Icons.calculate_rounded,
            iconColor: Color(0xFF55EFC4),
            isBold: true,
          ),
          ContentItem(
            text: 'α = 0.01 (N≈200): sensor de temperatura — variação lenta',
            icon: Icons.thermostat_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'α = 0.05 (N≈39): potenciômetro, joystick — suavização média',
            icon: Icons.gamepad_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'α = 0.1 (N≈19): ADC geral — bom compromisso',
            icon: Icons.memory_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'α = 0.3 (N≈6): resposta rápida — pouca filtragem',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'α = 0.5 (N≈3): quase sem filtro — detecção de pico',
            icon: Icons.show_chart_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
          ContentItem(
            text: 'Testar: plotar raw vs filtrado e ajustar visualmente',
            icon: Icons.auto_graph_rounded,
          ),
        ],
      );
    case 18:
      return const CodeSlide(
        key: ValueKey(18),
        title: 'EMA — Versão Inteira (Otimizada)',
        subtitle: 'ESP32 • Sem float • Shift em vez de multiplicação',
        accentColor: Color(0xFF55EFC4),
        code: '''// EMA com ponto fixo — alpha = 1/2^SHIFT
#define SHIFT 4  // alpha = 1/16 ≈ 0.0625

int32_t filtrado_q = 0;  // Q(SHIFT) format

int16_t ema_int(int16_t x) {
  // y = y + (x - y) >> SHIFT
  filtrado_q += ((int32_t)x - filtrado_q) >> SHIFT;
  return (int16_t)filtrado_q;
}

// Versão com alpha arbitrário (0-256)
#define ALPHA 26   // 26/256 ≈ 0.10
int32_t y_fixo = 0;

int16_t ema_fixo(int16_t x) {
  y_fixo = (ALPHA * (int32_t)x
         + (256 - ALPHA) * y_fixo) >> 8;
  return (int16_t)y_fixo;
}''',
        explanationPoints: [
          'Versão 1: α = 1/2^SHIFT (shift = divisão)',
          'SHIFT=4 → α=1/16 ≈ 0.0625 (filtragem forte)',
          'Versão 2: α = ALPHA/256 (qualquer valor)',
          'ALPHA=26 → α ≈ 0.10 (mesmo que float)',
          '>>8 = /256 (normalização por shift)',
          'Zero multiplicações float — máxima velocidade',
        ],
      );
    case 19:
      return const SectionTitleSlide(
        key: ValueKey(19),
        sectionNumber: '05',
        title: 'FFT — Fast Fourier Transform',
        subtitle:
            'Análise espectral em tempo real\nTransformando tempo → frequência',
        accentColor: Color(0xFF74B9FF),
        icon: Icons.graphic_eq_rounded,
      );
    case 20:
      return ContentSlide(
        key: const ValueKey(20),
        title: 'FFT — Conceito',
        subtitle: 'Decompondo sinais em frequências',
        accentColor: const Color(0xFF74B9FF),
        items: const [
          ContentItem(
            text: 'DFT: X[k] = Σ x[n] × e^(-j2πkn/N) — O(N²) operações',
            icon: Icons.functions_rounded,
            iconColor: Color(0xFF74B9FF),
            isBold: true,
          ),
          ContentItem(
            text: 'FFT: algoritmo Cooley-Tukey — reduz para O(N log N)',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF00D4AA),
            isBold: true,
          ),
          ContentItem(
            text: 'N = número de amostras (deve ser potência de 2)',
            icon: Icons.data_array_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'Saída: N/2 bins de frequência (0 a Fs/2)',
            icon: Icons.bar_chart_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Resolução em frequência: Δf = Fs / N',
            icon: Icons.calculate_rounded,
          ),
          ContentItem(
            text: 'N=1024, Fs=10kHz → Δf = 9.77 Hz, fmax = 5 kHz',
            icon: Icons.info_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Magnitude: |X[k]| = √(Re² + Im²) → espectro de amplitude',
            icon: Icons.graphic_eq_rounded,
          ),
        ],
      );
    case 21:
      return ContentSlide(
        key: const ValueKey(21),
        title: 'FFT — Resolução vs Velocidade',
        subtitle: 'Tradeoff entre precisão e tempo de processamento',
        accentColor: const Color(0xFF74B9FF),
        items: const [
          ContentItem(
            text: 'Mais amostras (N grande) → melhor resolução em frequência',
            icon: Icons.zoom_in_rounded,
            iconColor: Color(0xFF74B9FF),
            isBold: true,
          ),
          ContentItem(
            text: 'Mais amostras → mais tempo de aquisição e processamento',
            icon: Icons.timer_rounded,
            iconColor: Color(0xFFFF6B6B),
            isBold: true,
          ),
          ContentItem(
            text: 'N = 256: Δf = 39 Hz, ~1.5 ms processamento',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'N = 1024: Δf = 9.8 Hz, ~8 ms processamento',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'N = 4096: Δf = 2.4 Hz, ~40 ms processamento',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Windowing: Hann, Hamming, Blackman — reduz spectral leakage',
            icon: Icons.window_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text:
                'Zero-padding: interpola bins (visual) sem melhorar resolução real',
            icon: Icons.add_rounded,
          ),
        ],
      );
    case 22:
      return const CodeSlide(
        key: ValueKey(22),
        title: 'FFT — Código com arduinoFFT',
        subtitle: 'ESP32 • Análise espectral com biblioteca',
        accentColor: Color(0xFF74B9FF),
        code: '''#include <Arduino.h>
#include <arduinoFFT.h>

#define SAMPLES 1024
#define SAMPLING_FREQ 10000

double vReal[SAMPLES];
double vImag[SAMPLES];

ArduinoFFT<double> FFT(
  vReal, vImag, SAMPLES, SAMPLING_FREQ);

void setup() {
  Serial.begin(115200);
}

void loop() {
  // 1. Aquisição
  for (int i = 0; i < SAMPLES; i++) {
    vReal[i] = analogRead(34);
    vImag[i] = 0;
    delayMicroseconds(100);  // Ts = 100us
  }
  // 2. Janelamento + FFT
  FFT.windowing(FFTWindow::Hamming, FFTDirection::Forward);
  FFT.compute(FFTDirection::Forward);
  FFT.complexToMagnitude();
  // 3. Frequência dominante
  double peak = FFT.majorPeak();
  Serial.printf("Freq: %.1f Hz\\n", peak);
  delay(200);
}''',
        explanationPoints: [
          'arduinoFFT: biblioteca leve para ESP32',
          '1024 amostras a 10 kHz = resolução de ~10 Hz',
          'windowing(Hamming): reduz spectral leakage',
          'compute(): calcula a FFT (O(N log N))',
          'complexToMagnitude(): |X[k]|',
          'majorPeak(): frequência dominante do sinal',
        ],
      );
    case 23:
      return ContentSlide(
        key: const ValueKey(23),
        title: 'FFT — Interpretando o Espectro',
        subtitle: 'O que cada bin representa',
        accentColor: const Color(0xFF74B9FF),
        items: const [
          ContentItem(
            text: 'Bin k corresponde à frequência f = k × Fs / N',
            icon: Icons.bar_chart_rounded,
            iconColor: Color(0xFF74B9FF),
            isBold: true,
          ),
          ContentItem(
            text: 'Bin 0: componente DC (valor médio do sinal)',
            icon: Icons.horizontal_rule_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'Bins 1 a N/2-1: frequências de Δf a Fs/2 - Δf',
            icon: Icons.graphic_eq_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Bin N/2: frequência de Nyquist (Fs/2)',
            icon: Icons.vertical_align_top_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Magnitude alta → frequência presente no sinal',
            icon: Icons.arrow_upward_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'Picos harmônicos: 2f, 3f, 4f... indicam distorção',
            icon: Icons.waves_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
          ContentItem(
            text:
                'Floor de ruído: nível base sem picos → características do ADC',
            icon: Icons.show_chart_rounded,
          ),
        ],
      );
    case 24:
      return ContentSlide(
        key: const ValueKey(24),
        title: 'Windowing — Janelamento',
        subtitle: 'Reduzindo spectral leakage na FFT',
        accentColor: const Color(0xFF6C5CE7),
        items: const [
          ContentItem(
            text:
                'FFT assume sinal periódico — se N não é múltiplo do período → leakage',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFFF6B6B),
            isBold: true,
          ),
          ContentItem(
            text:
                'Window: multiplica o sinal por uma função que vai a zero nas bordas',
            icon: Icons.window_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'Rectangular (sem window): melhor resolução, mais leakage',
            icon: Icons.crop_square_rounded,
          ),
          ContentItem(
            text: 'Hann: bom compromisso resolução/leakage (uso geral)',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'Hamming: similar a Hann, lóbulos laterais menores',
            icon: Icons.check_circle_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Blackman: máxima redução de leakage, perda de resolução',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text:
                'Flat-top: preciso em amplitude (calibração), largo em frequência',
            icon: Icons.straighten_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
        ],
      );
    case 25:
      return const SectionTitleSlide(
        key: ValueKey(25),
        sectionNumber: '06',
        title: 'Filtros Notch e Band-Pass',
        subtitle: 'Rejeição e seleção de frequências específicas',
        accentColor: Color(0xFF6C5CE7),
        icon: Icons.tune_rounded,
      );
    case 26:
      return ContentSlide(
        key: const ValueKey(26),
        title: 'Filtro Notch — Rejeita-Faixa',
        subtitle: 'Eliminar 60 Hz (ruído da rede) do sinal',
        accentColor: const Color(0xFF6C5CE7),
        items: const [
          ContentItem(
            text: 'Notch: rejeita uma faixa estreita de frequências',
            icon: Icons.remove_circle_rounded,
            iconColor: Color(0xFF6C5CE7),
            isBold: true,
          ),
          ContentItem(
            text: 'Aplicação: remover interferência de 60 Hz (ou 50 Hz)',
            icon: Icons.bolt_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Implementação: IIR biquad com zeros na frequência rejeitada',
            icon: Icons.code_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'Q factor: determina largura da rejeição (Q alto = estreito)',
            icon: Icons.tune_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'Notch cascateado: 60 Hz + 120 Hz + 180 Hz (harmônicos)',
            icon: Icons.layers_rounded,
          ),
          ContentItem(
            text:
                'Cuidado: se o sinal tem componente em 60 Hz, ela será removida!',
            icon: Icons.warning_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
        ],
      );
    case 27:
      return ContentSlide(
        key: const ValueKey(27),
        title: 'Band-Pass — Passa-Faixa',
        subtitle: 'Selecionar apenas uma faixa de frequências',
        accentColor: const Color(0xFF55EFC4),
        items: const [
          ContentItem(
            text: 'Band-pass: permite apenas frequências entre f1 e f2',
            icon: Icons.center_focus_strong_rounded,
            iconColor: Color(0xFF55EFC4),
            isBold: true,
          ),
          ContentItem(
            text:
                'f1: frequência de corte inferior, f2: frequência de corte superior',
            icon: Icons.linear_scale_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'BW = f2 - f1: largura de banda do filtro',
            icon: Icons.straighten_rounded,
          ),
          ContentItem(
            text:
                'Implementação: cascata de high-pass (fc=f1) + low-pass (fc=f2)',
            icon: Icons.layers_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'Ou: biquad IIR band-pass direto (mais eficiente)',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'Aplicação: isolar batimento cardíaco (0.5-40 Hz)',
            icon: Icons.monitor_heart_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
          ContentItem(
            text:
                'Aplicação: detectar tom DTMF (frequência de tecla telefônica)',
            icon: Icons.phone_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
        ],
      );
    case 28:
      return const SectionTitleSlide(
        key: ValueKey(28),
        sectionNumber: '07',
        title: 'Aplicações Práticas',
        subtitle: 'DSP na ESP32 — Projetos reais',
        accentColor: Color(0xFF55EFC4),
        icon: Icons.devices_rounded,
      );
    case 29:
      return CardsSlide(
        key: const ValueKey(29),
        title: 'Aplicações de DSP',
        subtitle: 'Projetos reais com processamento de sinais na ESP32',
        accentColor: const Color(0xFF55EFC4),
        crossAxisCount: 3,
        cards: const [
          InfoCardData(
            title: 'Analisador de Espectro',
            description:
                'Visualização em tempo real de frequências (áudio, vibração).',
            icon: Icons.graphic_eq_rounded,
            color: Color(0xFF74B9FF),
          ),
          InfoCardData(
            title: 'Afinador Musical',
            description:
                'Detecta frequência fundamental de instrumentos via FFT.',
            icon: Icons.music_note_rounded,
            color: Color(0xFF6C5CE7),
          ),
          InfoCardData(
            title: 'ECG / Biomédico',
            description:
                'Filtros: notch 60Hz + band-pass 0.5-40Hz + detecção QRS.',
            icon: Icons.monitor_heart_rounded,
            color: Color(0xFFFF6B6B),
          ),
          InfoCardData(
            title: 'Diagnóstico Industrial',
            description:
                'Vibração de máquinas: FFT identifica desbalanceamento e desgaste.',
            icon: Icons.precision_manufacturing_rounded,
            color: Color(0xFFF59E0B),
          ),
          InfoCardData(
            title: 'Qualidade de Energia',
            description:
                'THD, harmônicos, fator de potência, medição true-RMS.',
            icon: Icons.bolt_rounded,
            color: Color(0xFF55EFC4),
          ),
          InfoCardData(
            title: 'Sonar / Ultrassônico',
            description:
                'Detecção de eco: filtro band-pass + correlação cruzada.',
            icon: Icons.radar_rounded,
            color: Color(0xFF00D4AA),
          ),
        ],
      );
    case 30:
      return ContentSlide(
        key: const ValueKey(30),
        title: 'DSP Performance na ESP32',
        subtitle: 'Benchmarks e limitações práticas',
        accentColor: const Color(0xFF74B9FF),
        items: const [
          ContentItem(
            text: 'ESP32 @ 240 MHz: ~100 MIPS (milhões de instruções/segundo)',
            icon: Icons.memory_rounded,
            iconColor: Color(0xFF74B9FF),
            isBold: true,
          ),
          ContentItem(
            text: 'FFT 1024 pontos (float): ~8 ms em 1 core',
            icon: Icons.timer_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'FFT 1024 pontos (int16): ~3 ms com ESP-DSP',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'EMA (1 amostra): ~0.1 µs (negligível)',
            icon: Icons.bolt_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'FIR 32 taps: ~3 µs por amostra → até 300 ksps',
            icon: Icons.calculate_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Dual core: Core 0 para aquisição, Core 1 para processamento',
            icon: Icons.view_column_rounded,
          ),
          ContentItem(
            text: 'ESP-DSP: biblioteca oficial com funções otimizadas (SIMD)',
            icon: Icons.code_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
        ],
      );
    case 31:
      return ContentSlide(
        key: const ValueKey(31),
        title: 'ESP-DSP — Biblioteca Oficial',
        subtitle: 'Funções DSP otimizadas para ESP32',
        accentColor: const Color(0xFF6C5CE7),
        items: const [
          ContentItem(
            text: 'GitHub: espressif/esp-dsp — componente IDF',
            icon: Icons.code_rounded,
            iconColor: Color(0xFF6C5CE7),
            isBold: true,
          ),
          ContentItem(
            text: 'dsps_fft2r: FFT radix-2 (int16 e float)',
            icon: Icons.graphic_eq_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text: 'dsps_biquad: filtro IIR biquad (cascata)',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF55EFC4),
          ),
          ContentItem(
            text: 'dsps_fir: filtro FIR com coeficientes float',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'dsps_wind: funções de janelamento (Hann, Hamming, Blackman)',
            icon: Icons.window_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text: 'Otimizações: SIMD (instructions), unrolling, alignment',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
          ContentItem(
            text: 'PlatformIO: lib_deps = espressif/esp-dsp@^1.3.0',
            icon: Icons.settings_rounded,
          ),
        ],
      );
    case 32:
      return CardsSlide(
        key: const ValueKey(32),
        title: 'Troubleshooting DSP',
        subtitle: 'Problemas comuns e soluções',
        accentColor: const Color(0xFFFF6B6B),
        crossAxisCount: 2,
        cards: const [
          InfoCardData(
            title: 'Aliasing no espectro',
            description:
                'Filtro anti-aliasing ausente. Adicionar RC passa-baixa antes do ADC.',
            icon: Icons.warning_rounded,
            color: Color(0xFFFF6B6B),
          ),
          InfoCardData(
            title: 'Pico em DC (bin 0)',
            description:
                'Sinal com offset. Subtrair média antes da FFT ou acrescentar capacitor AC.',
            icon: Icons.vertical_align_bottom_rounded,
            color: Color(0xFFF59E0B),
          ),
          InfoCardData(
            title: 'Spectral leakage',
            description:
                'Sinal não é periódico na janela. Aplicar windowing (Hann/Hamming).',
            icon: Icons.waves_rounded,
            color: Color(0xFF6C5CE7),
          ),
          InfoCardData(
            title: 'EMA com drift',
            description:
                'α muito pequeno → resposta muito lenta. Aumentar α ou usar timer preciso.',
            icon: Icons.trending_up_rounded,
            color: Color(0xFF55EFC4),
          ),
        ],
      );
    case 33:
      return ContentSlide(
        key: const ValueKey(33),
        title: 'Boas Práticas em DSP',
        subtitle: 'Dicas para processamento confiável',
        accentColor: const Color(0xFF55EFC4),
        items: const [
          ContentItem(
            text: 'Sempre use filtro anti-aliasing analógico antes do ADC',
            icon: Icons.filter_alt_rounded,
            iconColor: Color(0xFF55EFC4),
            isBold: true,
          ),
          ContentItem(
            text: 'Comece simples (EMA) e aumente complexidade se necessário',
            icon: Icons.trending_up_rounded,
            iconColor: Color(0xFF6C5CE7),
          ),
          ContentItem(
            text: 'Use timer ISR para amostragem precisa (não delay())',
            icon: Icons.timer_rounded,
            iconColor: Color(0xFF74B9FF),
          ),
          ContentItem(
            text:
                'Teste com sinal conhecido (gerador + DAC) antes do sinal real',
            icon: Icons.science_rounded,
            iconColor: Color(0xFFF59E0B),
          ),
          ContentItem(
            text:
                'Aritmética inteira para loops tight — float apenas no resultado',
            icon: Icons.speed_rounded,
            iconColor: Color(0xFF00D4AA),
          ),
          ContentItem(
            text: 'Use core dedicado (xTaskCreatePinnedToCore) para DSP pesado',
            icon: Icons.memory_rounded,
          ),
          ContentItem(
            text:
                'Documente: Fs, N, tipo de filtro, coeficientes, justificativa',
            icon: Icons.description_rounded,
            iconColor: Color(0xFFFF6B6B),
          ),
        ],
      );
    case 34:
      return CardsSlide(
        key: const ValueKey(34),
        title: 'Resumo e Próximos Passos',
        subtitle: 'Domine DSP na ESP32',
        accentColor: const Color(0xFF6C5CE7),
        crossAxisCount: 3,
        cards: const [
          InfoCardData(
            title: 'Média Móvel (FIR)',
            description:
                'Filtro mais simples. Buffer circular O(1). Boa para sensores.',
            icon: Icons.filter_alt_rounded,
            color: Color(0xFF74B9FF),
          ),
          InfoCardData(
            title: 'EMA (IIR 1ª ordem)',
            description: 'y=α·x+(1-α)·y. Um coeficiente. Versátil e eficiente.',
            icon: Icons.trending_up_rounded,
            color: Color(0xFF55EFC4),
          ),
          InfoCardData(
            title: 'IIR Biquad',
            description:
                '2ª ordem. Butterworth, Notch, Band-pass. Poucos coeficientes.',
            icon: Icons.loop_rounded,
            color: Color(0xFF6C5CE7),
          ),
          InfoCardData(
            title: 'FFT',
            description:
                'Análise espectral. arduinoFFT ou ESP-DSP. O(N log N).',
            icon: Icons.graphic_eq_rounded,
            color: Color(0xFF74B9FF),
          ),
          InfoCardData(
            title: 'Otimizações',
            description:
                'Inteiro > float. Timer ISR. Dual core. ESP-DSP otimizado.',
            icon: Icons.speed_rounded,
            color: Color(0xFFF59E0B),
          ),
          InfoCardData(
            title: 'Próxima Aula',
            description: 'FreeRTOS e Tempo Real — multitarefa na ESP32.',
            icon: Icons.arrow_forward_rounded,
            color: Color(0xFF34D399),
          ),
        ],
      );
    default:
      return Center(
        key: ValueKey(index),
        child: Text(
          'Slide ${index + 1}',
          style: const TextStyle(color: Colors.white38, fontSize: 22),
        ),
      );
  }
}
