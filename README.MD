# Airbnb Guest Support Assistant

Assistente de suporte ao cliente desenvolvido como projeto pessoal e demonstrativo utilizando o **Databricks Genie**.

O objetivo é demonstrar como recursos de análise de dados conversacional podem ser utilizados para consultar informações fictícias relacionadas a reservas do Airbnb e chamados de suporte, permitindo que usuários façam perguntas em linguagem natural e obtenham respostas baseadas nos dados disponíveis.

> **Aviso:** Este é um projeto fictício, desenvolvido para fins de estudo, aprendizado e demonstração. Não possui vínculo oficial com o Airbnb e não utiliza dados reais de clientes.

## Objetivos do projeto

- Explorar as funcionalidades do Databricks Genie.
- Permitir consultas a dados por meio de linguagem natural.
- Demonstrar o uso do Databricks SQL para análise de dados.
- Praticar a organização e o versionamento de recursos do Databricks utilizando Git e GitHub.
- Explorar o gerenciamento de recursos com Databricks Asset Bundles.

## Tecnologias utilizadas

- **Databricks Genie:** interface conversacional para consultas aos dados.
- **Databricks SQL:** execução de consultas e análise de dados.
- **SQL:** linguagem utilizada para consultas estruturadas.
- **Databricks CLI:** gerenciamento de recursos do workspace.
- **Databricks Asset Bundles:** organização e implantação dos recursos do projeto.
- **Git e GitHub:** versionamento e documentação.
- **PowerShell:** automação de tarefas locais.

## Funcionalidades

O assistente foi concebido para responder a perguntas relacionadas a reservas e atendimento ao cliente, conforme os dados e as configurações disponíveis no Genie Space.

Exemplos de perguntas:

- Quantas reservas existem na base de dados?
- Quais são os principais motivos de contato com o suporte?
- Quantos chamados estão pendentes?
- Qual é a distribuição dos chamados por categoria?
- Existem padrões nos problemas relatados pelos hóspedes?

As respostas dependem dos dados, das tabelas acessíveis e das instruções configuradas no Genie Space.

## Estrutura do repositório

```text
databricks-airbnb-guest-support-assistant/
├── resources/
│   └── airbnb_guest_support.genie_space.yml
├── scripts/
│   └── sync-genie-space.ps1
├── src/
│   └── airbnb_guest_support.geniespace.json
├── .gitignore
├── databricks.yml
└── README.md
```

### Principais arquivos

- `databricks.yml`: configuração do Databricks Asset Bundle.
- `resources/airbnb_guest_support.genie_space.yml`: definição do recurso Genie Space.
- `src/airbnb_guest_support.geniespace.json`: definição serializada do Genie Space.
- `scripts/sync-genie-space.ps1`: script PowerShell para verificar periodicamente alterações na definição do Genie Space e atualizar o arquivo local.
- `.gitignore`: arquivos e diretórios que não devem ser versionados.

## Sincronização do Genie Space

O projeto inclui um script para consultar a API do Databricks e verificar se a definição do Genie Space foi alterada.

Por padrão, a verificação acontece a cada 60 segundos.

Para executar o script no PowerShell, a partir da raiz do repositório:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\sync-genie-space.ps1
```

O script atualiza a cópia local da definição quando identifica alterações e cria um backup antes de substituir um arquivo existente.

Para interromper a execução, utilize `Ctrl + C`.

**Importante:** essa sincronização atualiza o arquivo local. Ela não realiza automaticamente commit ou push para o GitHub.

## Validação da configuração

Com o Databricks CLI instalado e autenticado, execute:

```powershell
databricks bundle validate --profile alvaro
```

O comando verifica a configuração do Asset Bundle. A validação não garante, por si só, que todos os recursos serão implantados com sucesso.

## Segurança e boas práticas

- Não versionar tokens, senhas ou credenciais.
- Não incluir informações confidenciais do ambiente de trabalho.
- Utilizar dados fictícios ou devidamente autorizados.
- Revisar os arquivos antes de enviá-los ao GitHub.
- Evitar expor endereços corporativos ou outros dados pessoais desnecessários em arquivos públicos.

## Limitações

Este projeto tem finalidade educacional e demonstrativa. Seu funcionamento depende das permissões, das configurações do workspace, das tabelas disponíveis e dos recursos habilitados no ambiente Databricks utilizado.

## Autor

Projeto pessoal desenvolvido para aprendizado e demonstração de recursos de análise de dados conversacional com Databricks.

---

Se este projeto ajudar nos seus estudos, fique à vontade para explorar, adaptar e evoluir a implementação.
