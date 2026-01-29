CREATE TYPE contrato_enum AS ENUM (
    'CCEAL',
    'ACR',
    'GD',
    'BATERIAS',
    'VAREJISTAS'
);

CREATE TYPE comprador_enum AS ENUM (
    'COMERCIALIZADORAS',
    'AGREGADORES',
    'CENTRAIS_COMPENSACAO',
    'COMERCIALIZADORAS_VAREJISTAS'
);

CREATE TYPE tecnologia_enum AS ENUM (
    'FOTOVOLTAICA',
    'ARMAZENAMENTO',
    'BIOGAS',
    'PCH'
);

CREATE TABLE municipio (
    id BIGSERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    latitude NUMERIC(9,6) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL
);

CREATE TABLE ator (
    id BIGSERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    telefone TEXT,
    email TEXT UNIQUE,
    cnpj_cpf TEXT UNIQUE
);

CREATE TABLE usina (
    id BIGSERIAL PRIMARY KEY,

    tecnologia tecnologia_enum NOT NULL,
    ator_id BIGINT NOT NULL REFERENCES ator(id),

    data_inicio_operacao TIMESTAMP,
    data_inicio_coleta TIMESTAMP,

    localizacao municipio_enum NOT NULL,
    tipo_comprador comprador_enum NOT NULL,
    tipo_contrato contrato_enum NOT NULL,

    reducao_co2_ano TEXT,

    media_energia_gerada_anual NUMERIC(18,2),
    media_energia_gerada_mensal NUMERIC(18,2),
    media_volume_vendido NUMERIC(18,2),
    capacidade_anual_geracao NUMERIC(18,2)
);

CREATE TABLE equipamento (
    id BIGSERIAL PRIMARY KEY,
    tipo_equipamento TEXT,
    fabricante TEXT,
    modelo TEXT,
    potencia_nominal NUMERIC(18,2),
    eficiencia_percent NUMERIC(5,2),
    ano_fabricacao INT,
    valor NUMERIC(18,2),
    vida_util_anos INT
);
CREATE TABLE usina_equipamento (
    usina_id BIGINT REFERENCES usina(id) ON DELETE CASCADE,
    equipamento_id BIGINT REFERENCES equipamento(id) ON DELETE CASCADE,
    PRIMARY KEY (usina_id, equipamento_id)
);
CREATE TABLE fotovoltaico (
    id BIGSERIAL PRIMARY KEY,
    usina_id BIGINT UNIQUE REFERENCES usina(id),

    area_ocupada_m2 NUMERIC(18,2),
    numero_modulos INT,
    tipo_modulo VARCHAR,
    eficiencia_modulos_percent NUMERIC(5,2),
    potencia_unitaria_modulo_w INT,
    tipo_inversor VARCHAR,
    quantidade_inversores INT,
    eficiencia_media_inversores_percent NUMERIC(5,2),
    tensao_nominal_sistema_v INT,
    irradiacao_media_kwh_m2_ano NUMERIC(18,2),
    temperatura_media_operacao_c NUMERIC(5,2),
    inclinacao_graus NUMERIC(5,2),
    orientacao_modulos VARCHAR,
    area_desmatada_ha NUMERIC(18,2),
    area_reaproveitada_ha NUMERIC(18,2)
);
CREATE TABLE biogas (
    id BIGSERIAL PRIMARY KEY,
    usina_id BIGINT UNIQUE REFERENCES usina(id),

    capacidade_instalada_mw NUMERIC(18,2),
    energia_gerada_mensal_mwh NUMERIC(18,2),
    energia_gerada_anual_mwh NUMERIC(18,2),
    tipo_substrato VARCHAR,
    quantidade_processada_t_dia NUMERIC(18,2),
    teor_solidos_percent NUMERIC(5,2),
    tipo_biodigestor VARCHAR,
    tratamento_biogas VARCHAR,
    equipamento_conversao VARCHAR,
    eficiencia_eletrica_percent NUMERIC(5,2),
    eficiencia_termica_percent NUMERIC(5,2),
    sistema_queima_excedente VARCHAR,
    producao_biogas_nm3_dia NUMERIC(18,2),
    pressao_media_bar NUMERIC(6,2),
    temperatura_media_c NUMERIC(6,2),
    reducao_emissoes_tco2eq_ano NUMERIC(18,2),
    destinacao_digestato VARCHAR
);
CREATE TABLE pch (
    id BIGSERIAL PRIMARY KEY,
    usina_id BIGINT UNIQUE REFERENCES usina(id),

    rio_aproveitado TEXT,
    vazao_media_m3s NUMERIC(18,2),
    vazao_turbinada_m3s NUMERIC(18,2),
    queda_bruta_m NUMERIC(18,2),
    queda_liquida_m NUMERIC(18,2),
    tipo_turbina TEXT,
    numero_turbinas INT,
    potencia_unitaria_turbina_mw NUMERIC(18,2),
    rendimento_turbina_percent NUMERIC(5,2),
    rendimento_gerador_percent NUMERIC(5,2),
    eficiencia_global_percent NUMERIC(5,2),
    tipo_gerador TEXT,
    tensao_nominal_sistema_kv NUMERIC(10,2),
    sistema_regulacao TEXT,
    nivel_tensao_conexao TEXT,
    subestacao_conexao TEXT,
    distribuidora_vinculada TEXT
);
CREATE TABLE armazenamento (
    id BIGSERIAL PRIMARY KEY,
    usina_id BIGINT UNIQUE REFERENCES usina(id),

    fator_capacidade_percent NUMERIC(5,2),
    tecnologia_bateria VARCHAR,
    fabricante_bateria VARCHAR,
    quantidade_modulos INT,
    capacidade_unitaria_kwh NUMERIC(18,2),
    tensao_nominal_sistema_v NUMERIC(10,2),
    corrente_nominal_a NUMERIC(10,2),
    profundidade_descarga_percent NUMERIC(5,2),
    vida_util_ciclos INT,
    tempo_recarga_horas NUMERIC(10,2),
    temperatura_operacao_c NUMERIC(6,2),
    sistema_gerenciamento_bms VARCHAR,
    sistema_conversao_potencia VARCHAR,
    eficiencia_conversao_percent NUMERIC(5,2),
    modalidade_operacao VARCHAR,
    tipo_conexao VARCHAR,
    nivel_tensao_conexao VARCHAR
);
