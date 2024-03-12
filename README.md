Loyaty Program | Custering
==============================

# 1. Problema de Negócio

A empresa é um Outlet multimarcas, ou seja ela comercializa produtos de segunda linha de várias marcas a um preço menor, através de um e-commerce.

Em 1 ano de operação, o time de marketing percebeu que alguns clientes da base compram produtos mais caros, com alta frequência e que eles representam uma parte significativa do faturamento da empresa.

Foi decidido pela criação de um programa de fidelidade para os melhores clientes (Insiders). O time de marketing precisa saber quem são estes clientes.

> Você é cientista de dados. Após a reunião mensal foi decidido que você, como Cientista de Dados, está encarregado de determinar quais são os clientes elegíveis para participar do Insiders. Com esta lista o time de Marketing fará campanhas personalizadas e exclusivas ao grup, para aumentar o faturamento e fequeência de compra.

| Problema | Causa Raiz | Questão principal |
| --- | --- | --- |
| Criar programa de fidelidade | Incrementar o faturamento | Quem são os clientes de alto valor? |


# 2. Suposições de Negócio
- Considerei valores na coluna "quantity" menores a 0 como sendo devoluções de uma compra.
- Valores da variável "stock_code" não exclusivamente numéricas serão excluidos, já que não há suficiente informção para saber do que se tratam .
- Aproximadamente 25% das transações não possuem um "customer_id". Foi criado um valor artificial para estas transações. É possível que alguns comportamentos de compra sejam perdidos.
 

# 3. Desenvolvimento da Solução
### 3.1. Produto Final
- Um reporte em csv com a lista dos clientes selecionados.
- Algoritmo treinado disponível na AWS para futuras clusterizações

### 3.2. Ferramentas
- Python, VS Code
- EC2, S3, RDS AWS
- Metabase
- Git, Github

### 3.3. Processo
O processo de solução do projeto é baseado na metodologia CRISP-DM, que é a sigla apra Cross Industry Process - Data Mining. É uma metodologia ágil que fornece uma estrutura robusta para planejamento de projetos de Machine Learning. Funciona como um processo cíclico, focado em entrega incremental a cada novo ciclo.


<img src="img/crisp-dm.png" style="zoom:100%;" />

* **Passo 01:** Descrição dos Dados: limpeza e descrição estatistica dos dados, afim de encontrar erros e comportamentos incomuns.
* **Passo 02:** Feature engineering: derivação de novas features, para modelar melhor o fenômeno.
* **Passo 03:** Filtragem de variáveis: remover linhas e colunas não necessárias para o modelo.
* **Passo 04:** Análise Exploratória de Dados: validação de hipóteses, busca por insights e entender melhor o impacto das variáveis no fenômeno.
* **Passo 05:** Preparação dos Dados: adequação dos dados para que o modelo de Machine Learning possa aprender corretamente.
* **Passo 06:** Seleção de Variáveis: selecionar as features mais significantes para treinar o modelo.
* **Passo 07:** Modelagem do Modelo: testar diferentes algoritmos de Machine Learning e comparar os resultados, afim de escolher um que perfome melhor para o conjunto de dados.
* **Passo 08:** Fine Tunnig: escolher os melhores valores para os hiperparâmetros do modelo selecionado anteriormente.
* **Passo 09:** Avaliação e Interpretação do Erro: converter o a performance do modelo de Machine Learnig em resultados de negócio.
* **Passo 10:** Deploy do model em produçãp: publicar o modelo em um ambiente de nuvem para que os envolvidos no projeto consigam acessar os resultados e melhorar suas decições de negócio.
    
# 4. Coleta de Dados

- **Dataset está disponível no repositório da University of Califoria: [clique aqui](https://archive.ics.uci.edu/dataset/352/online+retail)**
    
Este é um conjunto de dados transnacionais que contém todas as transações ocorridas entre 01/12/2010 e 09/12/2011 para um varejo on-line localizado no Reino Unido.

<img src="img/original_data_set.png" style="zoom:100%;" />
    
# 5. Top 3 Insights

### 5.1. Insights

Algumas hipóteses de negócio foram levantadas, para serem validadas ou não. No total foram levantadas 12 hipóteses, e dentro delas aqui estão os 3 top insights retirados da análise de dados e validação das hipoteses.

| **Insight 01 - Insiders faturam 10% acima do restante da base** |
| --- |
| <img src="img/gross_revenue.png" style="zoom:60%;" /> |

| **Insight 02 - Grupo Insiders tem a média de devolução menor que a base total** |
| --- |
| <img src="img/returns.png" style="zoom:60%;" /> | 

| **Insight 03 - Insiders tem volume de compra (produtos) maior que a base total** | 
| --- |
| <img src="img/qtde_products.png" style="zoom:60%;" /> | 


# 6. Feature Engineering

Usando o conjunto de dados original os algoritmos testados não foram capazes de  encontrar um comportamento de compra, ao ponto de conseguir separar os clusters de maneira satisfatória. Para resolver isso, derivei algums features do conjunto de dados orignial, agrupando todas por "customer_id" único. São elas:

['customer_id', 'gross_revenue', 'recency_days', 'qtde_invoices', 'qtde_items', 'qtde_products', 'avg_ticket', 'avg_recency_days', 'frequency', 'qtde_returns', 'avg_basket_size', 'avg_unique_basket_size', 'revenue_returned']

<img src="img/feature_eng.png" style="zoom:100%;" />


# 7. Espaço de dados | Embedding

Em projetos de clusterização, a escolha do espaço de representação dos dados desempenha um papel crucial. Tradicionalmente, utilizamos o espaço de features para realizar a clusterização. No entanto, este conjunto de dados não apresentara uma clusterização coesa no espaço de features. Uma abordagem inovadora para contornar este problema é empregar espaços de embedding como PCA, TNSE e UMAP (Uniform Manifold Approximation and Projection).

O UMAP, um método de redução de dimensionalidade, destaca-se por preservar a topologia e a estrutura local dos dados de forma eficaz. Ao utilizar espaços de embedding gerados pelo UMAP, em vez do espaço de features convencional, beneficiamos-nos da capacidade do UMAP em capturar relações não lineares complexas entre os pontos.

<img src="img/embedding_code.png" align="center" style="zoom:100%;" />

Esta abordagem permite uma melhor representação intrínseca dos dados, muitas vezes levando a agrupamentos mais significativos. Ao adotar espaços de embedding com UMAP para clusterização, exploramos de maneira mais eficiente a distribuição dos dados no espaço, promovendo uma visão mais precisa das relações latentes entre as observações.

Em comparação ao espaço de feartures, o ebedding baseado em um Random Forest apresentou uma capacidade muito maior em encontrar clusters coesos e separados entre si. Este é a visualização dos clusters formados no espaço de embedding formado com duas dimensões.

<img src="img/embedding.png" align="center" style="zoom:100%;" />


# 8. Hyperparameter Fine-Tuning

Encontrar o número correto de clusters pode ser um dos maiores desafios em problemas de clusterização. Uma das maneiras de encontrar o número de clusters ideal é o Elbow Method e a curva do Silhouette Score que compara o valor da métrica em relação a diferntes valores de clusters.

Em total, foram testados e comparados 5 modelos:
* K-Means
* Gaussian Mixture Model
* Hierarchical Clustering
* DBSCAN

Como o gráfico da curva de Silhouette Score mostra, usando o espaço de embedding o valor da métrica aumenta junto com o número de clusters. Porem um número de clusters muito alto não é factível para o time de Marketing conseguir manejar. 
Aqui é onde se mostra muito importante o entedimento de negócio por parte do Data Scientist e uma boa comunicação com os stakeholders do projeto para chegar a um valor que atenda as necessidades.

Para os fins deste projeto, o número de clusters foi definido em 11

<img src="img/elbow-method.png" style="zoom:100%;" />

<img src="img/silhouette-curve.png" align="center" style="zoom:10%;" />

Análise de silhoueta.
<img src="img/silhouette-analysis.png" align="center" style="zoom:10%;" />



# 7. EDA

Após a definição dos clusters, é momento de fazer uma análise do comportamento de cada um deles, e principalmente o cluster Insiders. Abaixo mostro o perfil de cada cluster, com alugumas métricas importates. Levando em consideração que 3 métricas pricipais foram levadas em conta para a definição do Insiders: Gross Revenue, Recency, Frequecy.
<img src="img/cluster-profile2.png" align="center" style="zoom:100%;" />

Também criei um dashboard, usando Metabase, para facilitar a visualização dos dados por parte do time de Marketing.
<img src="img/dashboard.png" align="center" style="zoom:100%;" />


# 8. Deployment

Neste ponto o modelo já está pronto para ir para produção e ser disponibilizado para o usuário final. O forma como este produto será entregue é um bot no telegram, onde o usuário insere o número de loja, e recebe as previsões de vendas para as próximas 6 semanas somadas.

Aqui você pode ver o funcionamento da API:

<img src="img/aws-architecture.jpeg" align="center" style="zoom:100%;" />

# 9. Resultados de Negócio

Uma parte importante de qualquer projeto de Data Science é traduzir os perfomance em resultados reais de negócio. Para este projeto, MAE (Mean Absolute Error), foi a métrica escolhida para explicar em valores reais a performance do modelo de Machine Learning. As previsões têm uma margem de erro, para mais ou para menos. 

Segue abaixo uma tablea, levando em consideração a margem de erro do modelo, apresentando assim o melhor e pior cenário da previsão de vendas.


<img src="img/scenarios.png" align="center" style="zoom:100%;" />

# 10. Conclusão

Após analizar os resultados conseguidos com o algorítmo, fica claro que o XGBoost é muito mais preciso em relação ao modelo que era usado anteriormente. O fenômeno que analisei neste projeto é complexo, envolvendo vários fatores que afetam as vendas. Foi necessário adaptar todo o projeto para este problema de série temporal.

Algumas lojas, como pode ser viso to gráfico abaixo, são mais dificeis para fazer a predição. Seria necessário um outro projeto dedicado somente ao tratamento destes outliers. Um novo ciclo do CRISP-DM poderia ser dedicado a isso.
<img src="img/prediction-final.png" align="center" style="zoom:100%;" />


Aqui vemos a soma da predição de todas as lojas nas próximas 6 semana. Isso dá ao CFO uma visão muito mais clara que quanto dinheiro ele tem diponível para investir na expansão das lojas, dando mais segurança se for preciso recorrer a empréstimos bancários para dar inicio as obras.

<img src="img/totalp-predictions.png" align="center" style="zoom:100%;" />

# 11. Próximos passos

- Procure dados externos como clima, eventos nacionais, indicadores macroeconomicos, entre outros.
- Derivar novas features no processo de feature engineering.
- Experimente o método de busca bayesiana na etapa de fine tunnig.
- Adicionar gráfico e tabelas ao bot do telegram.
