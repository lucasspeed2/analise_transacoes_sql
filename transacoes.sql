VER SE O VALOR DA TRANSAÇÃO ESTÁ NEGATIVADA:

select * from transacoes
where tipo = 'debito' or tipo = 'credito'
and valor <0;

-----------------------------------------------------------------------------------------------------------------------------------------------

VER COMO SE A TRANSAÇÃO DO CLIENTE ESTÁ CORRETA
select nome_cliente, valor, tipo, 
case when valor > 20000 then 'valor_alto'
else 'valor_ok' end as 'status_valor'
from transacoes;

-----------------------------------------------------------------------------------------------------------------------------------------------

VER QUAL É O TOTAL DE DEBITO E CREDITO POR CLIENTE
select nome_cliente,
	sum(case when tipo = 'credito' then valor else 0 end) as total_creditos,
    sum(case when tipo = 'debito' then valor else 0 end) as total_debitos
from transacoes
group by nome_cliente;

-----------------------------------------------------------------------------------------------------------------------------------------------


VER O VALOR LIQUIDO (GANHOS E PERDAS)
select nome_cliente,
	sum(case when tipo = 'credito' then valor else -valor end) as valor_liquido
    from transacoes
    group by nome_cliente;

-----------------------------------------------------------------------------------------------------------------------------------------------

VER SE TEM CLIENTE QUE FEZ MAIS DE UMA TRANSAÇÃO NO MESMO DIA:

select nome_cliente, data_transacao,
count(*) as quantidade from transacoes
group by nome_cliente, data_transacao
having count(*) >1;

-----------------------------------------------------------------------------------------------------------------------------------------------

VER QUAL O CLIENTE QUE MAIS FEZ MOVIMENTAÇÕES:

select nome_cliente,
	sum(abs(valor)) as movimentacao_total,
    rank() over (order by sum(abs(valor)) desc) as ranking
from transacoes
group by nome_cliente;

-----------------------------------------------------------------------------------------------------------------------------------------------

VER SE UM VALOR ESTÁ DE ACORDO COM OUTROS VALORES:

select * from transacoes
where valor > (
	select avg(valor) * 3 from transacoes
);


