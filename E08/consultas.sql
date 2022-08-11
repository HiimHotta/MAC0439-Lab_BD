
/***************************************************************
(a) Escreva uma consulta SQL que retorne os pares de cidade (x,y)
tais que é possível chegar em y a partir de x, por meio de um ou
mais voos realizados numa mesma data.
***************************************************************/
WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada FROM voo),

	Alcanca (origem, destino, partida, chegada) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada
			FROM Pares, Alcanca
		
			WHERE Pares.destino = Alcanca.origem
			  AND Pares.chegada < Alcanca.partida
			  AND Pares.origem != Alcanca.destino
		)
	)
SELECT * FROM Alcanca;


/***************************************************************
 (b) Encontre o número de todos os voos que não partem de Las
Vegas nem de uma cidade que é possível alcançar a partir de Los
Angeles por voo direto ou por uma ou mais conexões numa mesma
data.
***************************************************************/


WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada FROM voo 
              WHERE origem  != 'Las Vegas'
                AND origem  != 'Los Angeles'),

	Alcanca (origem, destino, partida, chegada) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada
			FROM Pares, Alcanca
		
			WHERE Pares.destino    = Alcanca.origem
			  AND Pares.chegada    < Alcanca.partida
			  AND Alcanca.destino != 'Los Angeles'
			  AND Pares.origem != Alcanca.destino
		)
	)
SELECT Count (*) FROM Alcanca;


/***************************************************************
(c) Escreva uma consulta SQL que retorne os pares de cidade (x,y)
tais que é possível chegar em y a partir de x numa mesma data,
mas não existe um voo direto de x para y.
***************************************************************/


WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada, 1 AS quant_voo FROM voo),

	Alcanca (origem, destino, partida, chegada, quant_voo) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada, Alcanca.quant_voo + 1
			FROM Pares, Alcanca
		
			WHERE Pares.destino    = Alcanca.origem
			  AND Pares.chegada    < Alcanca.partida
			  AND Pares.origem    != Alcanca.destino
		)
	)
SELECT * FROM Alcanca WHERE quant_voo > 1;

/***************************************************************
(d) Encontre o menor tempo total de viagem entre Los Angeles e
New York, por meio de nenhuma ou mais conexões realizadas numa
mesma data. Obs.: o tempo total de viagem inclui os tempos de
espera nas conexões.
***************************************************************/

WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada FROM voo),

	Alcanca (origem, destino, partida, chegada) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada
			FROM Pares, Alcanca
		
			WHERE Pares.destino = Alcanca.origem
			  AND Pares.chegada < Alcanca.partida
			  AND Pares.origem != Alcanca.destino
		)
	)

SELECT Min (chegada - partida) FROM Alcanca WHERE (origem = 'Los Angeles' AND destino = 'New York');

/***************************************************************
(e) Encontre o maior tempo total de voo existente no BD entre um
par de cidades conectadas por meio de um ou mais voos realizados
numa mesma data. Obs.: o tempo total de voo não inclui os tempos
de espera nas conexões.
***************************************************************/

WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada, CAST (chegada - partida as interval) AS tempo_voo FROM voo),

	Alcanca (origem, destino, partida, chegada, tempo_voo) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada, 
			    Alcanca.tempo_voo + (Pares.chegada - Pares.partida)
			FROM Pares, Alcanca
		
			WHERE Pares.destino = Alcanca.origem
			  AND Pares.chegada < Alcanca.partida
			  AND Pares.origem != Alcanca.destino
		)
	)
SELECT MAX (tempo_voo) FROM Alcanca;

/***************************************************************
 (f) Encontre todas as cidades possíveis de se alcançar a partir
de Los Angeles fazendo uma conexão em Las Vegas (podem haver
outras conexões, eventualmente) numa mesma data.
***************************************************************/


WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada FROM voo),

	Alcanca (origem, destino, partida, chegada) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada
			FROM Pares, Alcanca
		
			WHERE Pares.destino = Alcanca.origem
			  AND Pares.chegada < Alcanca.partida
			  AND Pares.origem != Alcanca.destino
		)
	)
SELECT * FROM Alcanca WHERE origem = 'Los Angeles';


/***************************************************************
(g) Escreva uma consulta SQL que retorne o conjunto de cidades x
que podem ser o ponto de partida para se chegar em pelo menos
duas outras cidades numa mesma data. Observe que ambas podem
estar diretamente ligadas a x por meio de um voo, em vez de uma
estar diretamente ligada e outra estar ligada por meio de uma
escala.
***************************************************************/
WITH RECURSIVE
	Pares AS (SELECT origem, destino, partida, chegada, 1 AS quant_voo FROM voo),

	Alcanca (origem, destino, partida, chegada, quant_voo) AS (
		(SELECT * FROM Pares)
		UNION
		(SELECT Pares.origem, Alcanca.destino, Pares.partida, Alcanca.chegada, Alcanca.quant_voo + 1
			FROM Pares, Alcanca
		
			WHERE Pares.destino    = Alcanca.origem
			  AND Pares.chegada    < Alcanca.partida
			  AND Pares.origem    != Alcanca.destino
		)
	)

	)
SELECT origem, COUNT (origem) 
 FROM (SELECT DISTINCT origem, destino FROM Alcanca) AS teste 
 GROUP BY origem HAVING COUNT (origem) > 1;

/***************************************************************
(h) Escreva uma consulta SQL que retorne o conjunto de pares de
cidades (x,y) tais que é possível chegar em y a partir de x numa
mesma data e que, a partir de y, pode-se chegar a no máximo uma
cidade.
***************************************************************/

