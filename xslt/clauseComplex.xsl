<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:variable name="chap" select="//chapter/@num"/>
	
	<xsl:variable name="words">
		<xsl:copy-of select="document('../mark/base/mark.xml')//chapter[@num=$chap]//w"/>
	</xsl:variable>
	
	<xsl:variable name="uc">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="lc">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	
	<xsl:template match="/">
	
		<html>
			<head>
				<title>Clause Complexes</title>
				<style type="text/css">
					.complex { margin-top: 20px; border: 1px solid black; padding: 10px;}
					
					.grk { font-family: Cardo; color: black}
					
					.complex-modifier-primary { margin-left: 20px; color: blue}
					.complex-modifier-secondary { margin-left: 50px; color: red}
					
					.id { font-family: Arial; font-size: 8pt; color: green;}
					.relation { width: 180px; font-size: 8pt;  font-family: Arial;}
					
					.complex-head { font-weight: bold;}
					
				</style>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-type"/>
			</head>
			<body> 
				<xsl:apply-templates select="//cl:clause[@level='primary'][not(@connect)]" mode="complex"/>
			</body>
		</html>
	
	</xsl:template>
	
	<xsl:template match="cl:clause" mode="complex">
	
		<xsl:variable name="id" select="@id"/>
	
		<div class="complex">

				<!-- all connected clauses before head clause -->
				<xsl:apply-templates select="preceding-sibling::cl:clause[@connect=$id]"/>
				
				
				<!-- head clause -->
				<div class="complex-head">
					<span class="id"><xsl:value-of select="substring-after(@id,'.')"/></span>
					<span class="grk"><xsl:apply-templates select=".//w"/></span>
				</div>
				<!-- all connected clauses after head clause -->
	
				<xsl:apply-templates select="following-sibling::cl:clause[@connect=$id]"/>


		</div>
	

		 
	
	</xsl:template>
	
	<xsl:template match="cl:clause">
			<xsl:variable name="id" select="@id"/>

		

	
		 <div class="complex-modifier-{@level}">
		 
		 	<!-- all connected clauses before head clause -->
				<xsl:apply-templates select="preceding-sibling::cl:clause[@connect=$id]"/>
				
	 
			<span class="relation"><xsl:value-of select="translate(@connectType1,$lc,$uc)"/> (<xsl:value-of select="@connectType2"/>)</span>
			<span class="id"><xsl:value-of select="substring-after(@id,'.')"/></span>
								<span class="grk"><xsl:apply-templates select=".//w"/></span>

<!-- all connected clauses after head clause -->
	
				<xsl:apply-templates select="following-sibling::cl:clause[@connect=$id]"/>

		</div>
		
						

		
	</xsl:template>
	
	<xsl:template match="w">
		<xsl:variable name="href" select="@xlink:href"/>
		<span class="w"><xsl:value-of select="$words//w[@id=$href]/wf"/></span>
	</xsl:template>
	
</xsl:stylesheet>
