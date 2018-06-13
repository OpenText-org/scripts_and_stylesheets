<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sql="http://apache.org/cocoon/SQL/2.0">
	<!-- 			#clause { position: absolute; left: 10px; top:10px; width: 95%; height: 20%; overflow: auto;} 			#comments { position: absolute; left: 10px; top: 52%; width: 95%; height: 40%; overflow: auto;} 			#form { position: absolute; left: 10px; top: 24%; width: 95%; height: 25%;  overflow: auto; 				border-top: solid 1px black; 				} -->
	<xsl:template match="/">
		<xsl:variable name="chapter" select="normalize-space(//chapter)"/>
		<xsl:variable name="clause" select="normalize-space(//mainClause)"/>
		<html>
			<head>
				<style type="text/css"> 

.wid { vertical-align: middle; font-family: Arial; margin-right: 1pt; padding-right: 0pt; 
					font-size: 7pt; color: green; text-decoration: none;}


			 			.odd { background-color: #d6ffc4;} 			.even { background-color: #ffffdd;} 			 			#comments {position: relative; overflow: auto; height: 50%; 				border: solid 2px outset; 				} 			#form {background-color: #e0f0d0;} 				 			.label { font-family: Verdana; font-size: 12px; text-align: left;} 			</style>
			</head>
			<body>
				<div id="clause">
					<xsl:apply-templates select="//clauses//cl:clause[not(ancestor::cl:clause)]">
						<xsl:with-param name="ancestor">clauses</xsl:with-param>
					</xsl:apply-templates>

				</div>
				<div id="form">
					<form action="insert" method="post">
						<table>
							<tbody>
								<tr>
									<th class="label">Annotator name</th>
									<th class="label">Enter your comment:</th>
								</tr>
								<tr>
									<td align="left" valign="top">
										<input type="hidden" name="clause">
											<xsl:attribute name="value"><xsl:value-of select="$clause"/></xsl:attribute>
										</input>
										<input type="hidden" name="chapter">
											<xsl:attribute name="value"><xsl:value-of select="$chapter"/></xsl:attribute>
										</input>
										<input type="hidden" name="book">
											<xsl:attribute name="value"><xsl:value-of select="normalize-space(//book)"/></xsl:attribute>
										</input>
										<select name="user">
											<xsl:for-each select="//users//sql:row">
												<option>
													<xsl:attribute name="value"><xsl:value-of select="*[1]"/></xsl:attribute>
													<xsl:value-of select="*[2]"/>
												</option>
											</xsl:for-each>
										</select>
										<br/>
										<br/>
										<input type="submit" value="Submit comment"/>
										<br/>
										<a>
											<xsl:attribute name="href"><xsl:text>chapter</xsl:text><xsl:value-of select="$chapter"/><xsl:text>#</xsl:text><xsl:value-of select="$clause"/></xsl:attribute> 										Return to chapter <xsl:value-of select="$chapter"/>
										</a>
									</td>
									<td>
										<textarea rows="6" cols="50" name="message"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				<div id="comments">
					<form action="updateStatus" method="post">
					<xsl:apply-templates select="//sql:rowset"/>
					<div style="text-align: right"><input type="submit" value="update status"/></div>
					</form>
				</div>
<!--
				<div id="clause">
					<h2>Revised version</h2>
					<xsl:apply-templates select="//newclauses//cl:clause[not(ancestor::cl:clause)]">
						<xsl:with-param name="ancestor">newclauses</xsl:with-param>
					</xsl:apply-templates>
				</div>
-->
			</body>
		</html>
	</xsl:template>
	<xsl:template match="sql:rowset[1][not(ancestor::users)]">
		<table width="100%">
			<tbody>
				<tr>
					<th class="label">Annotator</th>
					<th class="label">Comment</th>
					<th class="label">Date posted</th>
					<th class="label">Delete</th>
				</tr>
				<xsl:apply-templates select="sql:row"/>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="sql:row[not(ancestor::users)][not(sql:status='1')]">
		<tr>
			<xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2 = 0">even</xsl:when><xsl:otherwise>odd</xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:apply-templates select="*[not(self::sql:id)]"/>
			<td><input type="checkbox" name="c{sql:id}" value="0"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="*[parent::sql:row][not(ancestor::users)]">
		<td>
			<xsl:apply-templates/>
		</td>
	</xsl:template>



	<xsl:template match="*[parent::sql:row][ancestor::users]"/>

	<xsl:template match="cl:clause">
		<xsl:param name="ancestor"/>
		<xsl:variable name="id" select="@id"/>
		<table border="0">
			<tr>
				<td valign="center">
					<table border="1">
						<xsl:attribute name="bgcolor"><xsl:choose><xsl:when test="@level = 'primary'">pink</xsl:when><xsl:otherwise>#e0e0e0</xsl:otherwise></xsl:choose></xsl:attribute>
						<tr>
							<th style="font-family: arial">
								<xsl:value-of select="@id"/>
							</th>
							<xsl:apply-templates>
								<xsl:with-param name="ancestor"><xsl:value-of select="$ancestor"/></xsl:with-param>
							</xsl:apply-templates>
						</tr>
					</table>
				</td>
				<td valign="center">
					<xsl:apply-templates select="//cl:clause[ancestor::*[local-name()=$ancestor]][@level='secondary'][@connect=$id][ancestor::*[1]]">
	<xsl:with-param name="ancestor"><xsl:value-of select="$ancestor"/></xsl:with-param>

					</xsl:apply-templates>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="cl:S|cl:P|cl:A|cl:C">
		<xsl:param name="ancestor"/>
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table border="1">
					<td style="font-family: 'Georgia Greek'" valign="top">
						<table border="0">
							<tr>
								<th style="font-family: arial; font-size: 10pt">
									<center>
										<xsl:value-of select="local-name()"/>
									</center>
								</th>
							</tr>
							<tr>
								<td>
									<xsl:apply-templates select="text()|*[not(@connect)]">
										<xsl:with-param name="ancestor"><xsl:value-of select="$ancestor"/></xsl:with-param>
									</xsl:apply-templates>
								</td>
							</tr>
						</table>
					</td>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td style="font-family: 'Georgia Greek'" valign="top">
					<table border="0">
						<tr>
							<th style="font-family: arial; font-size: 10pt">
								<center>
									<xsl:value-of select="local-name()"/>
								</center>
							</th>
						</tr>
						<tr>
							<td>
									<xsl:apply-templates select="text()|*[not(@connect)]">
										<xsl:with-param name="ancestor"><xsl:value-of select="$ancestor"/></xsl:with-param>
									</xsl:apply-templates>

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
				<td style="font-family: 'Georgia Greek'">
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
		<span><span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
		<xsl:value-of select="translate(normalize-space(.),' ','')"/></span>

	</xsl:template>
</xsl:stylesheet>
