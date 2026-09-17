# Protótipo Assembly 🧬

[![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A524.10.5-brightgreen.svg)](https://www.nextflow.io/)
[![Conda](https://img.shields.io/badge/conda-environment-blue.svg)](https://docs.conda.io/)
[![Python](https://img.shields.io/badge/python-3.13-blue.svg)](https://www.python.org/)

>  **Repositório destinado ao projeto de Iniciação Científica (UFRN) voltado para a análise e customização do pipeline nf-core/genomeassembler para montagem de genomas eucariotos utilizando dados de sequenciamento de leitura longa.**
## Sobre o Projeto

A montagem de genomas é um passo crucial na bioinformática. Este projeto de Iniciação Científica tem como objetivo desenvolver um fluxo de trabalho (pipeline) automatizado, reprodutível e escalável para processar dados genômicos brutos e gerar montagens de alta qualidade. 

O pipeline foi construído utilizando **Nextflow** e desenhado para lidar com etapas essenciais da montagem, desde o controle de qualidade de sequenciamento de leituras longas até o mapeamento de anotações e extração de métricas de qualidade.

## Ferramentas
### Controle de Qualidade (QC)
*   **NANOQ (v0.10.0):** Utilizado para o controle de qualidade (QC) das leituras ONT, gerando relatórios de qualidade estruturados em formato JSON.

### Montagem *De Novo* e Conversão
*   **HIFIASM (v0.25.0):** Executa a montagem *de novo* utilizando as leituras de alta fidelidade (HiFi), produzindo um arquivo de grafo de montagem no formato `.gfa`.
*   **GFA2FA:** Ferramenta utilitária que realiza a conversão do grafo gerado pelo HIFIASM (`.gfa`) para o formato de sequência tradicional (`.fasta`).
*   **FLYE (v2.9.6):** Responsável pela montagem *de novo* independente utilizando as leituras longas da plataforma ONT, gerando o arquivo `.fasta`.

### Pós-processamento e Correção
*   **RAGTAG (v2.1.0):** Utilizado através da função `patch` para integrar e corrigir as montagens geradas. Ele combina os resultados do HIFIASM e do FLYE para gerar uma montagem final aprimorada e corrigida (`assembly_patched.fasta`).

### Anotação Genômica
*   **LIFTOFF (v1.6.3):** Realiza a projeção de genes da anotação de referência diretamente para a nova montagem corrigida, exportando o resultado final mapeado no formato `.gff3`.

---

## Estrutura do Repositório

O repositório segue as boas práticas de desenvolvimento de pipelines modulares:

```text
prototipo_assembly/
├── data/               # Diretório contendo os dados da amostra de teste
├── modules/            # Módulos Nextflow individuais para cada ferramenta
├── .gitignore          # Arquivos e pastas ignorados pelo git
├── environment.yml     # Arquivo do Conda com todas as dependências de software necessárias
├── main.nf             # Script principal do pipeline Nextflow
└── nextflow.config     # Arquivo de configuração de recursos computacionais
```
# Pré-requisitos e Execução do Pipeline

Este documento detalha os requisitos de sistema e os passos necessários para configurar o ambiente e executar o pipeline de montagem de genomas.

## Pré-requisitos

Para executar este fluxo de trabalho (pipeline) em sua máquina local ou em um cluster, certifique-se de ter os seguintes softwares instalados:

1. **Conda** Utilizado para o gerenciamento de pacotes e isolamento de dependências.
   - [Guia de instalação do Miniconda](https://docs.conda.io/en/latest/miniconda.html)

2. **Nextflow:** O orquestrador de workflow utilizado para gerenciar a execução do pipeline.
   - [Guia de instalação do Nextflow](https://www.nextflow.io/docs/latest/getstarted.html)

---

## Como Executar

Siga o passo a passo abaixo para baixar o projeto, configurar o ambiente e rodar as análises:

**1. Clone o repositório para a sua máquina:**
Abra o terminal e execute:
```bash
git clone https://github.com/eduardalou/prototipo_assembly.git
cd prototipo_assembly
```

**2. Crie e ative o ambiente virtual:**
O repositório contém um arquivo `environment.yml` com todas as dependências necessárias.
```bash
# Cria o ambiente baseado no arquivo de configuração
conda env create -f environment.yml

# Ative o ambiente criado
conda activate prototipo_assembly
```

**3. Execute o pipeline:**
Com o Nextflow e o Conda configurados, inicie a execução através do script principal `main.nf`:
```bash
nextflow run main.nf
```
