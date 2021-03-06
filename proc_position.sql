USE [DBcnvs]
GO
/****** Object:  StoredProcedure [dbo].[proc_position]    Script Date: 02/13/2017 20:35:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[proc_position](@CNVStart float,@CNVEnd float,@Chr varchar(500))
as
select top 500 
ss.SampleName as Sample_ID,ss.Gender as Gender,ss.EthnicGroup as Ethnic_Group,cnv.Chr as Chr,stuff((select distinct '，'+c.Band from DBcnv_CNVInfo as c inner join DBcnv_ChrInfo chr on c.ChrID=chr.ChrID where cnv.CNVname=c.CNVNAME FOR XML PATH('')),1,1,'')as Band,
reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvStart),1)),1,3,'')) as Start, reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvEnd),1)),1,3,''))as [End] ,reverse(stuff(reverse(convert(varchar,convert(money,cnv.size),1)),1,3,'')) as Size,cnv.point as Probe_Num,cnv.ratio as Log2Ratio,cnv.type as [Type],
stuff((select distinct '，'+g.Symbol from DBcnv_CNVInfo c WITH (INDEX=IX_CNVInfo_Name_B)inner join DBcnv_GeneInfo as g on c.GeneID=g.GeneID where c.CNVname=cnv.CNVNAME and g.Band=c.Band FOR XML PATH('')),1,1,'') as Gene ,
cnv.Reference as Reference
from DBcnv_CNVName cnv WITH(INDEX=IX_CNVName_C_S_E)
inner join DBcnv_SampleInfo ss on cnv.SampleID=ss.SampleID
 where ( cnv.CnvEnd>=@CNVStart and cnv.CnvStart<=@CNVEnd and cnv.Chr like @Chr and (cnv.ratio='N/A' or CONVERT(money,cnv.ratio)>=0.2 or CONVERT(money,cnv.ratio)<=-0.35))
 union
select top 500
ss.SampleName as Sample_ID,ss.Gender as Gender,ss.EthnicGroup as Ethnic_Group, cnv.Chr as Chr,stuff((select distinct '，'+c.Band from DBcnv_CNVInfo as c inner join DBcnv_ChrInfo chr on c.ChrID=chr.ChrID where cnv.CNVname=c.CNVNAME FOR XML PATH('')),1,1,'')as Band,
reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvStart),1)),1,3,''))  as Start,reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvEnd),1)),1,3,'')) as [End] ,reverse(stuff(reverse(convert(varchar,convert(money,cnv.size),1)),1,3,'')) as Size,cnv.point as Probe_Num,cnv.ratio as Log2Ratio,cnv.type as [Type],
stuff((select distinct '，'+g.Symbol from DBcnv_CNVInfo c WITH (INDEX=IX_CNVInfo_Name_B) inner join DBcnv_GeneInfo as g on c.GeneID=g.GeneID where c.CNVname=cnv.CNVNAME and g.Band=c.Band FOR XML PATH('')),1,1,'') as Gene ,
cnv.Reference as Reference
from DBcnv_CNVName cnv WITH(INDEX=IX_CNVName_C_S_E)
inner join DBcnv_SampleInfo ss on cnv.SampleID=ss.SampleID
 where  (cnv.CnvStart<=@CNVStart and cnv.CnvEnd>=@CNVEnd and cnv.Chr like @Chr and (cnv.ratio='N/A' or CONVERT(money,cnv.ratio)>=0.2 or CONVERT(money,cnv.ratio)<=-0.35))
 union
select top 500
ss.SampleName as Sample_ID,ss.Gender as Gender,ss.EthnicGroup as Ethnic_Group, cnv.Chr as Chr,stuff((select distinct '，'+c.Band from DBcnv_CNVInfo as c inner join DBcnv_ChrInfo chr on c.ChrID=chr.ChrID where cnv.CNVname=c.CNVNAME FOR XML PATH('')),1,1,'')as Band,
reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvStart),1)),1,3,''))  as Start,reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvEnd),1)),1,3,''))as [End] ,reverse(stuff(reverse(convert(varchar,convert(money,cnv.size),1)),1,3,'')) as Size,cnv.point as Probe_Num,cnv.ratio as Log2Ratio,cnv.type as [Type],
stuff((select distinct '，'+g.Symbol from DBcnv_CNVInfo c WITH (INDEX=IX_CNVInfo_Name_B)inner join DBcnv_GeneInfo as g on c.GeneID=g.GeneID where c.CNVname=cnv.CNVNAME and g.Band=c.Band FOR XML PATH('')),1,1,'') as Gene ,
cnv.Reference as Reference
from DBcnv_CNVName cnv WITH(INDEX=IX_CNVName_C_S_E)
inner join DBcnv_SampleInfo ss on cnv.SampleID=ss.SampleID
 where (cnv.CnvStart<=@CNVStart and cnv.CnvEnd>=@CNVStart and cnv.Chr like @Chr and cnv.CnvEnd<=@CNVEnd and (cnv.ratio='N/A' or CONVERT(money,cnv.ratio)>=0.2 or CONVERT(money,cnv.ratio)<=-0.35))
 union
select top 500
ss.SampleName as Sample_ID,ss.Gender as Gender,ss.EthnicGroup as Ethnic_Group, cnv.Chr as Chr,stuff((select distinct '，'+c.Band from DBcnv_CNVInfo as c inner join DBcnv_ChrInfo chr on c.ChrID=chr.ChrID where cnv.CNVname=c.CNVNAME FOR XML PATH('')),1,1,'')as Band,
reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvStart),1)),1,3,''))  as Start,reverse(stuff(reverse(convert(varchar,convert(money,cnv.CnvEnd),1)),1,3,'')) as [End] ,reverse(stuff(reverse(convert(varchar,convert(money,cnv.size),1)),1,3,'')) as Size,cnv.point as Probe_Num,cnv.ratio as Log2Ratio,cnv.type as [Type],
stuff((select distinct '，'+g.Symbol from DBcnv_CNVInfo c WITH (INDEX=IX_CNVInfo_Name_B) inner join DBcnv_GeneInfo as g on c.GeneID=g.GeneID where c.CNVname=cnv.CNVNAME and g.Band=c.Band FOR XML PATH('')),1,1,'') as Gene ,
cnv.Reference as Reference
from DBcnv_CNVName cnv WITH(INDEX=IX_CNVName_C_S_E)
inner join DBcnv_SampleInfo ss on cnv.SampleID=ss.SampleID
 where (cnv.CnvStart<=@CNVEnd and cnv.CnvEnd>=@CNVEnd and cnv.Chr like @Chr and cnv.CnvStart>=@CNVStart and (cnv.ratio='N/A' or CONVERT(money,cnv.ratio)>=0.2 or CONVERT(money,cnv.ratio)<=-0.35))