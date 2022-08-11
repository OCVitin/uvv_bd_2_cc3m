CREATE ROLE abrantes
	WITH
  	LOGIN
	SUPERUSER
	INHERIT
 	CREATEDB
    CREATEROLE
	REPLICATION;
	
-- selecionando usuário
ALTER ROLE abrantes;
-- criando o banco de dados
CREATE DATABASE zoologico 
    WITH
    OWNER  abrantes
    TEMPLATE  template0
    ENCODING  'UTF-8'
    LC_COLLATE  'pt_BR.UTF-8'
    LC_CTYPE  'pt_BR.UTF-8'
    ALLOW_CONNECTIONS  true;
	
-- conectando o usuário ao banco de dados
\connect zoologico abrantes
-- criando esquema e dando autorização
CREATE SCHEMA IF NOT EXISTS trabalho
    AUTHORIZATION abrantes;
-- conectando o usuário ao esquema
SET SEARCH_PATH TO trabalho, abrantes, public;

-- criando tabela que irá armazenar os estados
CREATE TABLE trabalho.uf (
                uf VARCHAR(2) NOT NULL,
                nome_estado VARCHAR(50) NOT NULL,
                CONSTRAINT uf_pk PRIMARY KEY (uf)
);
COMMENT ON TABLE trabalho.uf IS 'Tabela que guarda as UFs dos endereços dos funcionários.';
COMMENT ON COLUMN trabalho.uf.uf IS 'Sigla do estado. PK da tabela.';
COMMENT ON COLUMN trabalho.uf.nome_estado IS 'Nome do estado.';

-- criando tabela que irá armazenar as cidades
CREATE TABLE trabalho.cidades (
                codigo_cidade VARCHAR(10) NOT NULL,
                nome_cidade VARCHAR(50) NOT NULL,
                uf VARCHAR(2) NOT NULL,
                CONSTRAINT cidades_pk PRIMARY KEY (codigo_cidade)
);
COMMENT ON TABLE trabalho.cidades IS 'Tabela que contém as cidades dos endereços dos funcionários.';
COMMENT ON COLUMN trabalho.cidades.codigo_cidade IS 'Código da cidade. PK da tabela.';
COMMENT ON COLUMN trabalho.cidades.nome_cidade IS 'Nome da cidade.';
COMMENT ON COLUMN trabalho.cidades.uf IS 'Sigla do estado. PK da tabela.';

-- criando tabela que irá armazenar os bairros
CREATE TABLE trabalho.bairros (
                codigo_bairro VARCHAR(10) NOT NULL,
                nome_bairro VARCHAR(50) NOT NULL,
                codigo_cidade VARCHAR(10) NOT NULL,
                CONSTRAINT bairros_pk PRIMARY KEY (codigo_bairro)
);
COMMENT ON TABLE trabalho.bairros IS 'Tabela que contém os bairros dos endereços dos funcionários.';
COMMENT ON COLUMN trabalho.bairros.codigo_bairro IS 'Código do bairro. PK da tabela.';
COMMENT ON COLUMN trabalho.bairros.nome_bairro IS 'Nome do bairro.';
COMMENT ON COLUMN trabalho.bairros.codigo_cidade IS 'Código da cidade. PK da tabela.';

-- criando tabela que irá armazenar os setores
CREATE TABLE trabalho.setor (
                codigo_setor VARCHAR(10) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT codigo_setor_pk PRIMARY KEY (codigo_setor)
);
COMMENT ON TABLE trabalho.setor IS 'Tabela que contém os dados dos diversos setores do zoológico.';
COMMENT ON COLUMN trabalho.setor.codigo_setor IS 'Código do setor. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.setor.nome IS 'Nome do setor.';

-- criando tabela que irá armazenar os dados dos funcionários
CREATE TABLE trabalho.funcionarios (
                cpf VARCHAR(11) NOT NULL,
                cpf_gerente VARCHAR(11) NOT NULL,
                nome VARCHAR(100) NOT NULL,
                data_nascimento_funcionario DATE NOT NULL,
                data_contratacao DATE NOT NULL,
                turno CHAR(1) NOT NULL,
                salario NUMERIC(6,2) NOT NULL,
                codigo_setor VARCHAR(10) NOT NULL,
                telefone VARCHAR(11) NOT NULL,
                logradouro VARCHAR(20) NOT NULL,
                numero_endereco INTEGER NOT NULL,
                complemento_endereco VARCHAR(100) NOT NULL,
                cep VARCHAR(8) NOT NULL,
                codigo_bairro VARCHAR(10) NOT NULL,
                codigo_cidade VARCHAR(10) NOT NULL,
                uf VARCHAR(2) NOT NULL,
                CONSTRAINT cpf_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE trabalho.funcionarios IS 'Tabela que guarda os dados dos funcionários do zoológico.';
COMMENT ON COLUMN trabalho.funcionarios.cpf IS 'CPF do funcionário (ex.: 12345678901). PK da tabela.';
COMMENT ON COLUMN trabalho.funcionarios.cpf_gerente IS 'CPF do gerente do funcionário.';
COMMENT ON COLUMN trabalho.funcionarios.nome IS 'Nome completo do funcionário.';
COMMENT ON COLUMN trabalho.funcionarios.data_nascimento_funcionario IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN trabalho.funcionarios.data_contratacao IS 'Data de contratação do funcionário.';
COMMENT ON COLUMN trabalho.funcionarios.turno IS 'Turno do funcionário (M para manhã, T para tarde, N para noite).';
COMMENT ON COLUMN trabalho.funcionarios.salario IS 'Salário mensal do funcionário.';
COMMENT ON COLUMN trabalho.funcionarios.codigo_setor IS 'Código do setor. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.funcionarios.telefone IS 'Telefone do funcionário, com DDD (ex.: xx xxxx xxxx).';
COMMENT ON COLUMN trabalho.funcionarios.logradouro IS 'Logradouro do endereço.';
COMMENT ON COLUMN trabalho.funcionarios.numero_endereco IS 'Número da residência.';
COMMENT ON COLUMN trabalho.funcionarios.complemento_endereco IS 'Complemento do endereço (número do apartamento, referência).';
COMMENT ON COLUMN trabalho.funcionarios.cep IS 'CEP do endereço.';
COMMENT ON COLUMN trabalho.funcionarios.codigo_bairro IS 'Código do bairro. PK da tabela.';
COMMENT ON COLUMN trabalho.funcionarios.codigo_cidade IS 'Código da cidade. PK da tabela.';
COMMENT ON COLUMN trabalho.funcionarios.uf IS 'Sigla do estado. PK da tabela.';

-- criando tabela que irá armazenar as famílias que um grupo de espécies pertencem
CREATE TABLE trabalho.familia (
                codigo_familia VARCHAR(10) NOT NULL,
                codigo_setor VARCHAR(10) NOT NULL,
                nome VARCHAR(20) NOT NULL,
                CONSTRAINT codigo_familia_pk PRIMARY KEY (codigo_familia, codigo_setor)
);
COMMENT ON TABLE trabalho.familia IS 'Tabela que guarda os dados das famílias dos animais.';
COMMENT ON COLUMN trabalho.familia.codigo_familia IS 'Código da família do animal. PK da tabela.';
COMMENT ON COLUMN trabalho.familia.codigo_setor IS 'Código do setor. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.familia.nome IS 'Nome da família do animal (ex.: felídeos, giraffidae, etc.).';

-- criando tabela que irá armazenar os dados sobre habitats
CREATE TABLE trabalho.habitat (
                codigo_habitat VARCHAR(10) NOT NULL,
                codigo_setor VARCHAR(10) NOT NULL,
                nome_habitat VARCHAR(30) NOT NULL,
                CONSTRAINT codigo_habitat_pk PRIMARY KEY (codigo_habitat)
);
COMMENT ON TABLE trabalho.habitat IS 'Tabela que registra os habitats em que os animais moram.';
COMMENT ON COLUMN trabalho.habitat.codigo_habitat IS 'Código do habitat. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.habitat.codigo_setor IS 'Código do setor. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.habitat.nome_habitat IS 'Nome do habitat.';

-- criando tabela que irá armazenar os dados sobre as espécies
CREATE TABLE trabalho.especie (
                codigo_especie VARCHAR(10) NOT NULL,
                codigo_habitat VARCHAR(10) NOT NULL,
                nome_cientifico VARCHAR(30) NOT NULL,
                comportamento VARCHAR(50) NOT NULL,
                expectativa_de_vida INTEGER NOT NULL,
                CONSTRAINT codigo_especie_pk PRIMARY KEY (codigo_especie, codigo_habitat)
);
COMMENT ON TABLE trabalho.especie IS 'Tabela que contém as informações das espécies.';
COMMENT ON COLUMN trabalho.especie.codigo_especie IS 'Código da espécie. PK da tabela.';
COMMENT ON COLUMN trabalho.especie.codigo_habitat IS 'Código do habitat. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.especie.nome_cientifico IS 'Nome científico da espécie.';
COMMENT ON COLUMN trabalho.especie.comportamento IS 'Comportamento da espécie (agressivo, noturno, etc.)';
COMMENT ON COLUMN trabalho.especie.expectativa_de_vida IS 'Expectativa de vida média da espécie.';

-- criando tabela que irá armazenar os dados sobre as dietas das espécies
CREATE TABLE trabalho.dieta (
                codigo_dieta VARCHAR(10) NOT NULL,
                codigo_especie VARCHAR(10) NOT NULL,
                predominancia VARCHAR(30) NOT NULL,
                restricoes VARCHAR(50) NOT NULL,
                alimentos_permitidos VARCHAR(200) NOT NULL,
                CONSTRAINT c_digo_dieta_pk PRIMARY KEY (codigo_dieta, codigo_especie)
);
COMMENT ON TABLE trabalho.dieta IS 'Tabela que guarda os dados das dietas de cada espécie.';
COMMENT ON COLUMN trabalho.dieta.codigo_dieta IS 'Código da dieta. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.dieta.codigo_especie IS 'Código da espécie. PK da tabela.';
COMMENT ON COLUMN trabalho.dieta.predominancia IS 'Alimentação predominante da espécie (carnívoro, ovíparo, etc.).';
COMMENT ON COLUMN trabalho.dieta.restricoes IS 'Alimentos proibidos para cada espécie.';
COMMENT ON COLUMN trabalho.dieta.alimentos_permitidos IS 'Especificações de alimentos liberados para cada espécie (tipos de plantas ou carnes, etc.).';

-- criando tabela que irá armazenar as informações dos animais individualmente
CREATE TABLE trabalho.animais (
                codigo_identificador VARCHAR(10) NOT NULL,
                codigo_especie VARCHAR(10) NOT NULL,
                nome VARCHAR(30) NOT NULL,
                data_nascimento_animal DATE NOT NULL,
                sexo CHAR(1) NOT NULL,
                observacoes VARCHAR(1000) NOT NULL,
                familia_codigo_familia VARCHAR(10) NOT NULL,
                codigo_setor VARCHAR(10) NOT NULL,
                CONSTRAINT codigo_identificador_pk PRIMARY KEY (codigo_identificador, codigo_especie)
);
COMMENT ON TABLE trabalho.animais IS 'Tabela que guarda as informações individuais de cada animal do zoológico.';
COMMENT ON COLUMN trabalho.animais.codigo_identificador IS 'Código que identifica cada animal individual. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.animais.codigo_especie IS 'Código da espécie. PK da tabela.';
COMMENT ON COLUMN trabalho.animais.nome IS 'Nome ou apelido do animal.';
COMMENT ON COLUMN trabalho.animais.data_nascimento_animal IS 'Data de nascimento do animal.';
COMMENT ON COLUMN trabalho.animais.sexo IS 'Sexo do animal.';
COMMENT ON COLUMN trabalho.animais.codigo_familia IS 'Código da família do animal.';
COMMENT ON COLUMN trabalho.animais.observacoes IS 'Observações sobre o animal (histórico médico, restrições, etc.)';
COMMENT ON COLUMN trabalho.animais.familia_codigo_familia IS 'Código da família do animal. PK da tabela.';
COMMENT ON COLUMN trabalho.animais.codigo_setor IS 'Código do setor. Parte da PK da tabela.';

-- criando tabela que irá armazenar as informações sobre as atrações
CREATE TABLE trabalho.atracoes (
                codigo_atracao VARCHAR(10) NOT NULL,
                nome VARCHAR(100) NOT NULL,
                horario TIME NOT NULL,
                codigo_identificador VARCHAR(10) NOT NULL,
                codigo_especie VARCHAR(10) NOT NULL,
                codigo_setor VARCHAR(10) NOT NULL,
                CONSTRAINT codigo_atracao_pk PRIMARY KEY (codigo_atracao)
);
COMMENT ON TABLE trabalho.atracoes IS 'Tabela que contém os dados das atrações e eventos do zoológico.';
COMMENT ON COLUMN trabalho.atracoes.codigo_atracao IS 'Código da atração. PK da tabela.';
COMMENT ON COLUMN trabalho.atracoes.nome IS 'Nome da atração.';
COMMENT ON COLUMN trabalho.atracoes.horario IS 'Horário da atração.';
COMMENT ON COLUMN trabalho.atracoes.codigo_identificador IS 'Código que identifica cada animal individual. Parte da PK da tabela.';
COMMENT ON COLUMN trabalho.atracoes.codigo_especie IS 'Código da espécie. PK da tabela.';
COMMENT ON COLUMN trabalho.atracoes.codigo_setor IS 'Código do setor. Parte da PK da tabela.';


ALTER TABLE trabalho.cidades ADD CONSTRAINT uf_cidades_fk
FOREIGN KEY (uf)
REFERENCES trabalho.uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.funcionarios ADD CONSTRAINT uf_funcionarios_fk
FOREIGN KEY (uf)
REFERENCES trabalho.uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.bairros ADD CONSTRAINT cidades_bairros_fk
FOREIGN KEY (codigo_cidade)
REFERENCES trabalho.cidades (codigo_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.funcionarios ADD CONSTRAINT cidades_funcionarios_fk
FOREIGN KEY (codigo_cidade)
REFERENCES trabalho.cidades (codigo_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.funcionarios ADD CONSTRAINT bairros_funcionarios_fk
FOREIGN KEY (codigo_bairro)
REFERENCES trabalho.bairros (codigo_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.habitat ADD CONSTRAINT setor_habitat_fk
FOREIGN KEY (codigo_setor)
REFERENCES trabalho.setor (codigo_setor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.familia ADD CONSTRAINT setor_familia_fk
FOREIGN KEY (codigo_setor)
REFERENCES trabalho.setor (codigo_setor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.atracoes ADD CONSTRAINT setor_atracoes_fk
FOREIGN KEY (codigo_setor)
REFERENCES trabalho.setor (codigo_setor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.funcionarios ADD CONSTRAINT setor_funcionarios_fk
FOREIGN KEY (codigo_setor)
REFERENCES trabalho.setor (codigo_setor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.funcionarios ADD CONSTRAINT funcionarios_funcionarios_fk
FOREIGN KEY (cpf_gerente)
REFERENCES trabalho.funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.animais ADD CONSTRAINT familia_animais_fk
FOREIGN KEY (codigo_setor, familia_codigo_familia)
REFERENCES trabalho.familia (codigo_setor, codigo_familia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.especie ADD CONSTRAINT habitat_especie_fk
FOREIGN KEY (codigo_habitat)
REFERENCES trabalho.habitat (codigo_habitat)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.dieta ADD CONSTRAINT especie_dieta_fk
FOREIGN KEY (codigo_especie)
REFERENCES trabalho.especie (codigo_especie)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.animais ADD CONSTRAINT especie_animais_fk
FOREIGN KEY (codigo_especie)
REFERENCES trabalho.especie (codigo_especie)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalho.atracoes ADD CONSTRAINT animais_atracoes_fk
FOREIGN KEY (codigo_identificador, codigo_especie)
REFERENCES trabalho.animais (codigo_identificador, codigo_especie)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;