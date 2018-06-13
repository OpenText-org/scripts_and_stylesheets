<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xalan="http://xml.apache.org/xalan" xmlns:ot="http://www.opentext.org/data"
                   exclude-result-prefixes="xalan"
>
 
 	<xsl:output method="xml" encoding="UTF-8" version="1.0"/>
 
	<xsl:param name="book">mark</xsl:param>	
	<xsl:param name="ch"/>
 
 

	 <xsl:variable name="showIDs">0</xsl:variable>


	<ot:values>
	
	
		<select name="clauseType" >
				<option value="">-</option>
				<option value="independent">independent</option>
				<option value="dependent">dependent</option>
				<option value="relative">relative</option>
				<option value="participle">participle</option>
				<option value="infinitive">infinitive</option>
			</select>	
	
	<select name="connectType">
					<option value="">-</option>
					 
					  <option value="projected">projected</option>
					 
				<optgroup label="LOGICAL">
					 <option value="connective">connective</option>
					 <option value="contrastive">contrastive</option>
					 <option value="correlative">correlative</option>
					 <option value="disjunctive">disjunctive</option>
					 <option value="emphatic">emphatic</option>
					 <option value="explanatory">explanatory</option>
					 <option value="disjunctive">disjunctive</option>
					 <option value="inferential">inferential</option>
					 <option value="transitional">transitional</option>
					 <option value="asyndeton">asyndeton</option>	
				 </optgroup>
				 
				 <optgroup label="ADVERBIAL">
					 <option value="causal">causal</option>
					 <option value="comparative">comparative (manner)</option>
					  <option value="conditional">conditional</option>
					  <option value="local">local (sphere)</option>
					  <option value="purpose">purpose</option>
					  <option value="result">result</option>
					  <option value="temporal">temporal</option>
				</optgroup>	
				 
				 <optgroup label="SUBSTANTIVAL">
					 <option value="content">content</option>
					 <option value="epexegetical">epexegetical</option>
				</optgroup>							
 
					 
	</select>
	<select name="subtype">
				 
				<optgroup label="independent">
					<option value="">--</option>

				</optgroup>	
				<optgroup label="dependent">
					<option value="purpose">purpose</option>
					<option value="causal">causal</option>
					<option value="content">content</option>
					<option value="locative">locative</option>
					<option value="temporal">temporal</option>
					<option value="comparative">comparative</option>
					<option value="conditional-protasis">conditional - protasis</option>
				</optgroup>	
				<optgroup label="relative">
					<option value="definite">definite</option>
					<option value="indefinite">indefinite</option>
				</optgroup>					
				<optgroup label="participle">
					<option value="substantival">substantival</option>
					<option value="attributive">attributive</option>
					<option value="predicative">predicative</option>
					<option value="genitive absolute">genitive absolute</option>
					<option value="adverbial-concessive">adverbial - concessive</option>
					<option value="adverbial-causal">adverbial - causal</option>
					<option value="adverbial-conditional">adverbial - conditional</option>
					<option value="adverbial-instrumental">adverbial - instrumental</option>
					<option value="adverbial-purpose">adverbial - purpose</option>
				</optgroup>
				<optgroup label="infinitive">
					<option value="substantival">substantival</option>
					<option value="appositional">appositional</option>
					 <option value="catenative">catenative</option>
					<option value="purpose/result">purpose/result</option>
					<option value="causal">causal</option>
					<option value="temporal">temporal</option>
				</optgroup>	
			</select>	
	
	</ot:values>


	 <xsl:template match="/">
		 <html>
				<head>
					<title>Edit clause types</title>
					<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>	
					
					<meta content="-1" http-equiv="Expires"/>	
					  <meta content="no-cache" http-equiv="Pragma"	/>
					
					<style type="text/css">
					
								.grk, .clauseGrk { font-family: Cardo, 'Georgia Greek',  'Palatino Linotype',  'Arial Unicode MS' ; font-size: 9pt;}
					
						.comphead { font-size: 8pt; font-weight: bold; }
						
						.cid { font-size: 8pt; color: green; font-family: Arial; text-align: left;}
						
						.clauses { position: relative; overflow: auto; height: 90%; }
						
						.connect { font-size: 8pt; color: blue; font-family: Arial; background-color: #d0d0d0; }
						
						select { font-size: 9pt; }
						
					</style>
					<script>

					<xsl:for-each select="document('')//select[@name='subtype']/optgroup">
				
					<xsl:text>function subtype_</xsl:text>
					<xsl:value-of select="@label"/>
					<xsl:text>(cid, sel)</xsl:text>
					{
						 
						<xsl:for-each select="option">
						<xsl:variable name="opt" select="concat('opt',position())"/>
						var <xsl:value-of select="$opt"/>=document.createElement('option');
						<xsl:value-of select="$opt"/>.value='<xsl:value-of select="@value"/>';
						var txt = document.createTextNode('<xsl:value-of select="."/>');
						<xsl:value-of select="$opt"/>.appendChild(txt);
						sel.appendChild(<xsl:value-of select="$opt"/>);
						</xsl:for-each>
						return sel;
					}
				</xsl:for-each>
					
					
						function changeSubtype(cid, selnode)
						{
							var val = selnode[selnode.selectedIndex].value;
							var sel = document.getElementById('clauseSubtype_' + cid);
							 
						   
							 sel.innerHTML="";
				 
							 eval('subtype_'+val+'("' + cid + '", sel)');
							 
					
						}
					
					</script>
				</head>
				<body>
				 <form action="updateClauseTypes" method="post">
					 <input type="hidden" name="book" value="{$book}"/>
					 <input type="hidden" name="ch" value="{$ch}"/>
					 <input type="submit" value="Update values"/>
					 <div class="clauses">
					<xsl:apply-templates/>
					</div>
				 </form>	
				</body>
			</html>
	 </xsl:template>
		 
	
		<xsl:template match="cl:clause">
		<xsl:variable name="id" select="@id"/>
		<table border="0">
 
			<tr>
				<td>
					<table border="1">
						<xsl:attribute name="bgcolor"><xsl:choose><xsl:when test="@level = 'primary'">pink</xsl:when><xsl:otherwise>#f0f0f0</xsl:otherwise></xsl:choose></xsl:attribute>
						<tr>
							<th class="cid">
								<xsl:value-of select="@id"/>
							 
								<div>
									<select name="clauseType_{@id}" onchange="changeSubtype('{@id}', this)">
											<xsl:apply-templates select="document('')//select[@name='clauseType']/*" mode="opt">
												<xsl:with-param name="optval" select="@clauseType"/>
											</xsl:apply-templates>
									</select>
								</div>
								<div>	
									<select name="clauseSubtype_{@id}">
										 
									
									<xsl:choose>
										<xsl:when test="@clauseSubtype">
										<xsl:variable name="clauseSubtype" select="@clauseSubtype"/>	
											<xsl:apply-templates select="document('')//optgroup[@label=current()/@clauseType]/option" mode="opt">
													<xsl:with-param name="optval" select="$clauseSubtype"/>		
											</xsl:apply-templates>	
										</xsl:when>
									 	
									</xsl:choose>
									
									</select>
								</div>
								
								
								<div style="white-space: mp">
									<input type="text" size="10" name="connect_{@id}" class="connect" value="{@connect}"/>
									
									<select name="connectType_{@id}">
									 
									
									<xsl:apply-templates select="document('')//select[@name='connectType']/*" mode="opt">
										<xsl:with-param name="optval" select="current()/@connectType"/>
									</xsl:apply-templates>
									</select>
								</div>
							 
							</th>
							<xsl:apply-templates/>
						</tr>
					</table>
				</td>
			</tr>

		</table>
	</xsl:template>
	<xsl:template match="cl:S|cl:P|cl:A|cl:C">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table border="1">
					<td  class="grk" valign="top">
						<table border="0">
							<tr>
								<th class="comphead">
									<center>
										<xsl:value-of select="local-name()"/>
									</center>
								</th>
							</tr>
							<tr>
								<td>
									<xsl:apply-templates select="text()|*[not(@connect)]"/>
								</td>
							</tr>
						</table>
					</td>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td  class="grk" valign="top">
					<table border="0">
						<tr>
							<th class="comphead">
							 
									<xsl:value-of select="local-name()"/>
								 
							</th>
						</tr>
						<tr>
							<td>
								<xsl:apply-templates select="text()|*[not(@connect)]"/>
							</td>
						</tr>
					</table>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="pl:conj">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name()='A' or local-name()='C' or local-name()='P']">
				<span style="text-decoration: underline; font-family: 'Georgia Greek'">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<td style="text-decoration: underline; font-family: 'Georgia Greek'">
					<xsl:apply-templates/>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="cl:conj">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name()='A' or local-name()='C' or local-name()='P']">
				<table>
					<tr>
						<th>
							<xsl:text/>
						</th>
					</tr>
					<tr>
						<td>
							<xsl:apply-templates/>
						</td>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td  class="grk">
					<table>
						<tr>
							<th>
								<xsl:text/>
							</th>
						</tr>
						<tr>
							<td>
								<xsl:apply-templates/>
							</td>
						</tr>
					</table>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<xsl:template match="w">
    <xsl:if test="$showIDs=1">
        <span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
    </xsl:if>
 
 
    <xsl:value-of select="wf"/>&#160;
 
</xsl:template>

<xsl:template match="domains"/>

<xsl:template match="option" mode="opt">
	<xsl:param name="optval"/>
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:if test="$optval = @value"><xsl:attribute name="selected">1</xsl:attribute>	</xsl:if>
		<xsl:apply-templates/>	
	</xsl:copy>
</xsl:template>

<xsl:template match="optgroup" mode="opt">
		<xsl:param name="optval"/>
		<xsl:copy>
		<xsl:copy-of select="@*"/>
		 
		<xsl:apply-templates mode="opt">
			<xsl:with-param name="optval" select="$optval"/>		
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
