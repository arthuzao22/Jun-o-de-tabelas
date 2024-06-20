 -- ------------------------------------------------------------------------ RELACIONAR 077 COM 008
 IF OBJECT_ID('#SEQUE_008') IS NOT NULL DROP TABLE #SEQUE_008
 SELECT 
        *, 
    CASE 
        WHEN CHARINDEX('-', REVERSE(cd_registro_caed)) > 0
        THEN SUBSTRING(
                 cd_registro_caed, 
                 CHARINDEX('-', cd_registro_caed) + 1, 
                 CHARINDEX('-', cd_registro_caed, CHARINDEX('-', cd_registro_caed) + 1) - CHARINDEX('-', cd_registro_caed) - 1
             )
        ELSE NULL
    END AS N_DC_ITEM,
    NU_SEQUENCIAL AS CD_NU_SEQUENCIAL,
    CASE 
        WHEN CHARINDEX('-', REVERSE(cd_registro_caed)) > 0
        THEN RIGHT(
                 cd_registro_caed, 
                 CHARINDEX('-', REVERSE(cd_registro_caed)) - 1
             )
        ELSE NULL
    END AS CORRECAO_CD
	INTO #SEQUE_008
FROM PARC_2024_ENTRADA.dbo.RECORTE_PARC_C6_1853_ARQ_DA_008_D_1308_20240618092833_005649605; -- SEMPRE ATUALIZAR AS TABELAS


/*AQUI FAZ A JUNÇÃO DA 008 E DA 077*/
SELECT B.CD_NU_SEQUENCIAL, B.VL_CAMPO_005, B.VL_CAMPO_009, B.VL_CAMPO_013, A.*
--INTO #J008e077
FROM [REPOSITORIO_MTD].[dbo].ARQ_SO_077_D_1308_20240620091632_000579224  A
INNER JOIN #SEQUE_008 B
ON B.CD_NU_SEQUENCIAL = A.NU_SEQUENCIAL 
AND B.N_DC_ITEM = A.CD_ITEM
AND B.CORRECAO_CD = A.NU_CORRECAO
/*--------------------------------*/


/*AQUI FAZ A JUNÇÃO DA 005 E DA 009*/
SELECT * FROM
PARC_2024_ENTRADA.dbo.RECORTE_PARC_C6_1853_ARQ_DA_005_D_1308_20240618092454_002023924 A
INNER JOIN PARC_2024_ENTRADA.DBO.ARQ_SU_009_D_1308_20240618112247_002023924 B
ON A.CD_ENTIDADE_ADMINISTRATIVA = B.CD_ENTIDADE_ADMINISTRATIVA
/*--------------------------------*/
