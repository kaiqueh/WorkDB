# Banco de Dados USR_FITNESS

Este repositório contém a estrutura e os scripts necessários para criar e gerenciar o banco de dados **USR_FITNESS**, voltado para o gerenciamento de membros, planos de treinamento, exercícios e históricos em academias de fitness.

---

## 🎯 Objetivo do Banco de Dados

O banco de dados **USR_FITNESS** tem como objetivo armazenar e gerenciar informações relacionadas a:
- Membros de uma academia, incluindo dados pessoais.
- Planos de treinamento oferecidos, com descrições detalhadas.
- Rotinas de treinamento associadas a cada plano, com detalhes de exercícios.
- Histórico de adesão dos membros aos planos.

Esse banco permite que academias mantenham o controle sobre as atividades de seus membros e ofereçam planos de treinamento personalizados.

---

## 📂 Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

### 1. `USR_FITNESS_MEMBROS`
Armazena informações dos membros da academia.

- **Colunas**:
  - `MEMBRO_ID`: Identificador único do membro (**PK**).
  - `NOME`: Nome completo do membro.
  - `DATA_NASCIMENTO`: Data de nascimento.
  - `TELEFONE`: Contato do membro.
  - `EMAIL`: Endereço de e-mail.
  
- **Relacionamento**:
  - Referenciado por `HISTORICO_TREINAMENTO` através de `MEMBRO_ID`.

---

### 2. `USR_FITNESS_PLANOS_TREINAMENTO`
Contém informações sobre os planos de treinamento disponíveis.

- **Colunas**:
  - `PLANO_ID`: Identificador único do plano (**PK**).
  - `NOME`: Nome do plano.
  - `DESCRICAO`: Descrição detalhada do plano.
  - `DURACAO_SEMANAS`: Duração do plano em semanas.

- **Relacionamento**:
  - Referenciado por `ROTINAS_TREINAMENTO` e `HISTORICO_TREINAMENTO` através de `PLANO_ID`.

---

### 3. `USR_FITNESS_EXERCICIOS`
Registra exercícios utilizados nas rotinas de treinamento.

- **Colunas**:
  - `EXERCICIO_ID`: Identificador único do exercício (**PK**).
  - `NOME`: Nome do exercício.
  - `TIPO`: Tipo do exercício (ex.: força, aeróbico).
  - `DESCRICAO`: Descrição detalhada do exercício.

- **Relacionamento**:
  - Referenciado por `ROTINAS_TREINAMENTO` através de `EXERCICIO_ID`.

---

### 4. `USR_FITNESS_ROTINAS_TREINAMENTO`
Define as rotinas de treinamento para cada plano.

- **Colunas**:
  - `ROTINA_ID`: Identificador único da rotina (**PK**).
  - `PLANO_ID`: Plano associado (**FK**, referencia `PLANOS_TREINAMENTO`).
  - `EXERCICIO_ID`: Exercício associado (**FK**, referencia `EXERCICIOS`).
  - `SERIES`: Quantidade de séries.
  - `REPETICOES`: Quantidade de repetições.
  - `DESCANSO_SEGUNDOS`: Tempo de descanso entre séries (em segundos).

---

### 5. `USR_FITNESS_HISTORICO_TREINAMENTO`
Registra o histórico de adesão dos membros aos planos.

- **Colunas**:
  - `HISTORICO_ID`: Identificador único do histórico (**PK**).
  - `MEMBRO_ID`: Membro associado (**FK**, referencia `MEMBROS`).
  - `PLANO_ID`: Plano associado (**FK**, referencia `PLANOS_TREINAMENTO`).
  - `DATA_INICIO`: Data de início do plano.
  - `DATA_FIM`: Data de término do plano (pode ser nula se o plano estiver em andamento).
  - `STATUS`: Status atual do plano (ex.: "Ativo", "Concluído").

---

## ⚙️ Como Executar os Scripts no Oracle

### Requisitos
1. Tenha o Oracle Database configurado e em execução.
2. Use uma ferramenta como **SQL*Plus**, **SQL Developer** ou outro cliente SQL compatível.

### Etapas de Execução

1. **Criação do Schema**
   - Antes de rodar os scripts, crie o schema do banco de dados. Você pode usar o seguinte comando no Oracle:
     ```sql
     CREATE USER USR_FITNESS IDENTIFIED BY fitness_senha;
     GRANT CONNECT, RESOURCE TO USR_FITNESS;
     ```

2. **Execução dos Scripts DDL**
   - Abra a ferramenta SQL de sua escolha e conecte-se ao schema `USR_FITNESS`.
   - Execute o script `estrutura.sql` para criar as tabelas e as sequências:
     ```sql
     @estrutura.sql
     ```

3. **Inserção de Dados (DML)**
   - Insira os dados iniciais no banco executando o script `dados.sql`:
     ```sql
     @dados.sql
     ```

4. **Validação**
   - Verifique se os dados foram inseridos corretamente com consultas simples:
     ```sql
     SELECT * FROM USR_FITNESS_MEMBROS;
     SELECT * FROM USR_FITNESS_PLANOS_TREINAMENTO;
     ```

---

## 🚀 Testes e Considerações

- Certifique-se de que o ambiente esteja limpo antes de rodar os scripts (use `DROP TABLE` e `DROP SEQUENCE` conforme necessário).
- Caso encontre problemas com sequências, reinicie-as conforme descrito abaixo:
  ```sql
  ALTER SEQUENCE SEQUENCIA_NOME RESTART START WITH 1;
