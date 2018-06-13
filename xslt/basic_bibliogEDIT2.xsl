<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sql="http://apache.org/cocoon/SQL/2.0" exclude-result-prefixes="sql">
	<xsl:output method="xtml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Basic bibliographic information</title>
				<style type="text/css">
				
					.menubar { position: absolute;
						top: 10px; left: 10px;
						background-color: #c0c0c0;
						width: 300px;
					}
			
					
				
					.bib { margin-bottom: 30px;
						   position: absolute; visibility: visible;
						   top: 40px; left: 10px;
						   background-color: #e0e0e0;
						   height: 80%;
						   width: 95%;
						   overflow: auto;
						}
						
					.formats {
						   position: absolute; visibility: hidden;
						   top: 40px; left: 10px;
						   background-color: #e0e0e0;
							width: 95%;
						   height: 80%;
						   overflow: auto;
						}
					
					.button_on { background-color: #e0e0e0;
							border: outset 2pt white;
							border-bottom: 0pt;
							font-family: Arial; font-size: 10pt; padding: 4px;


							 display: block; color: black; font-weight: bold;
							 text-decoration: none;
							}
							
					.button_off { background-color: #c0c0c0; border: solid 1px #f0f0f0;
							border-bottom: 0px;
							 font-family: Arial; font-size: 10pt; padding: 4px;
							 display: block; color: white; font-weight: bold;
							 text-decoration: none;
							}
							
					.button_off:hover { color: white; border-color: red;}
					
					.controls { position: absolute; top: 90%}

					.tablegrouphead { border-top: dotted 2px black; 
							padding: 5px;
							background-color: #a0a0a0;
							color: white;
							text-decoration: underline;
							font-size: small;
						}


					.dateboxvisible { position: relative; display: show;}
					.dateboxhidden { position: relative; display: none;}
					

				</style>

				<script language="JavaScript" src="calendar.js"/>

				<script>
					var currentButton = "titletab";
				
					function select(id, button)
					{
						current = document.getElementById(currentButton);
						current.style.backgroundColor = "#c0c0c0";
						current.style.color = "white";
						current.style.border = "solid 1px white";
						current.style.borderBottom = "0px";
						current.onclick = function() { select(this.id, this);};
						current.onmouseover = function() { this.style.borderColor='red';};
						current.onmouseout = function() { this.style.borderColor='white';};
								
							
								
						button.style.backgroundColor = "#e0e0e0";
						button.style.border = "outset 2pt white";
						button.style.color = "black";
						button.onmouseover = "";
						button.onmouseout = "";
						button.onclick = "";
						
				
						
					
						active = document.getElementById(id.substr(0,id.indexOf('tab')));
						active.style.visibility = "visible";
						inactive = document.getElementById(currentButton.substr(0,currentButton.indexOf('tab')));
						inactive.style.visibility = "hidden";
					
						currentButton = id;
						
					}
				</script>
				
			</head>
			<body>
		
		<form action="updateTitle" method="post" name="titleForm">
				
				<div class="controls">
					<input type="submit" value="Update record"  onclick="document.getElementById('updateOrAdd').value = 1"/>
					<input type="submit" value="Add new formats" onclick="document.getElementById('updateOrAdd').value = 0"/>
					<input type="hidden" name="updateOrAdd" value="1"/>
				</div>

				<div class="menubar">
					<table border="0">
						<tbody>
							<tr>
								<td>
									<span id="titletab" class="button_on">Title</span>
								</td>
								
								<xsl:for-each select="//formats//sql:formatabbrev">
									<td>
										<span id="{.}tab" 
												class="button_off" 
												onmouseover="this.style.borderColor='red'" 
												onmouseout="this.style.borderColor='white'" 
												onclick="select(this.id, this)"><xsl:value-of select="."/></span>
									</td>	
								</xsl:for-each>

									
							</tr>
						</tbody>
					</table>
				</div>
		

					<xsl:apply-templates select="//bib"/>
					<xsl:apply-templates select="//formats"/>
			
				</form>
				
				
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="bib">
	
		<div class="bib" id="title">
				<input type="hidden" value="{.//sql:titleid}" name="titleID"/>
				<table border="0">
					<tbody>
						<tr>
							<td>Title</td>
							<td colspan="3">
								<input type="text" name="title" onchange="document.getElementById('titleFlag').value = 1" size="50">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:title"/></xsl:attribute>
								</input>
								<input type="hidden" name="titleFlag" value="0"/>
							</td>
							
				
							
						</tr>
						<tr>
							<td>Series</td>
							<td colspan="3">
								<input type="text" name="series" onchange="document.getElementById('seriesFlag').value = 1" size="50">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:series"/></xsl:attribute>
								</input>
								<input type="hidden" name="seriesFlag" value="0"/>

							</td>
							
	
						</tr>
						
						<tr>
							<td>Author</td>
							<td>
								<input type="text" name="author" onchange="document.getElementById('authorFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:author"/></xsl:attribute>
								</input>
								<input type="hidden" name="authorFlag" value="0"/>

							</td>
							
								<td>Publisher</td>
							<xsl:variable name="currentPub" select=".//sql:publisherid"/>
							<td>
								<select name="publisherID" onchange="document.getElementById('publisherIDFlag').value = 1">
									<option>---</option>
									<xsl:for-each select="//publishers//sql:row">
										
										<xsl:choose>
											<xsl:when test="$currentPub = sql:publisherid ">
												<option value="{sql:publisherid}" selected="yes">
													<xsl:value-of select="sql:publishername"/>
												</option>
											</xsl:when>
											<xsl:otherwise>
												<option value="{sql:publisherid}">
													<xsl:value-of select="sql:publishername"/>
												</option>
											</xsl:otherwise>
										</xsl:choose>

									</xsl:for-each>
								</select>
								<input type="hidden" name="publisherIDFlag" value="0"/>
							</td>
						</tr>
						
						<tr>
		
							<td>Author 2</td>
							<td>
								<input type="text" name="author2" onchange="document.getElementById('author2Flag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:author2"/></xsl:attribute>
								</input>
								<input type="hidden" name="author2Flag" value="0"/>

							</td>

					<td>Imprint</td>
							<td>
								<input type="text" name="imprint" onchange="document.getElementById('imprintFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:imprint"/></xsl:attribute>
								</input>
								<input type="hidden" name="imprintFlag" value="0"/>

							</td>
					</tr>
					<tr>
			
							<td>Author 3</td>
							<td>
								<input type="text" name="author3" onchange="document.getElementById('author3Flag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:author3"/></xsl:attribute>
								</input>
								<input type="hidden" name="author3Flag" value="0"/>

							</td>
		
														<td>Category 1</td>
							<td>
								<input type="text" name="category1" onchange="document.getElementById('category1Flag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:category1"/></xsl:attribute>
								</input>
								<input type="hidden" name="category1Flag" value="0"/>
							</td>			
					

						</tr>
	
						<tr>							
							<td>Suggested retail price <br/> (format: 1234.56)</td>
							<td>
								<input type="text" name="suggestedRetailPrice" onchange="document.getElementById('suggestedRetailPriceFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:suggestedretailprice"/></xsl:attribute>
								</input>
								<input type="hidden" name="suggestedRetailPriceFlag" value="0"/>
							</td>
							
							<td>Category 2</td>
							<td>
								<input type="text" name="category2" onchange="document.getElementById('category2Flag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:category2"/></xsl:attribute>
								</input>
								<input type="hidden" name="category2Flag" value="0"/>
							</td>		
						</tr>
						<tr>							
							<td>Print ISBN</td>
							<td>
								<input type="text" name="printISBN" onchange="document.getElementById('printISBNFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:printisbn"/></xsl:attribute>
								</input>
								<input type="hidden" name="printISBNFlag" value="0"/>
							</td>
							
														<td>Category 3</td>
							<td>
								<input type="text" name="category3" onchange="document.getElementById('category3Flag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:category3"/></xsl:attribute>
								</input>
								<input type="hidden" name="category3Flag" value="0"/>
							</td>			
							
						</tr>
						<tr>							
							<td>Print Publication Date</td>
							<td>
								<input type="text" name="printPubDate" onchange="document.getElementById('printPubDateFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:printpubdate2"/></xsl:attribute>
								</input>
								<a href="javascript:printpubdate.popup();" onclick="document.getElementById('printPubDateFlag').value = 1;">
									<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
								</a>
								<input type="hidden" name="printPubDateFlag" value="0"/>
							</td>
							
												<td>Use cover image</td>
							<td>
								<select name="useCoverImage" onchange="document.getElementById('useCoverImageFlag').value = 1">
									<option>---</option>
									<xsl:choose>
										<xsl:when test=".//sql:usecoverimage = 0">
											<option value="0" selected="yes">no</option>
											<option value="1">yes</option>				
										</xsl:when>
										<xsl:when test=".//sql:usecoverimage = 1">
											<option value="0">no</option>
											<option value="1" selected="yes">yes</option>	
										</xsl:when>
										<xsl:otherwise>
											<option value="0">no</option>
											<option value="1">yes</option>				
										</xsl:otherwise>
									</xsl:choose>
								</select>
								<input type="hidden" name="useCoverImageFlag" value="0"/>	
							</td>
							
						</tr>	
						<tr>							
							<td>Page count</td>
							<td>
								<input type="text" name="pageCount" onchange="document.getElementById('pageCountFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:pagecount"/></xsl:attribute>
								</input>
								<input type="hidden" name="pageCountFlag" value="0"/>
							</td>
						</tr>
						<tr>
							<td>Keywords</td>
							<td colspan="3">
								<input type="text" name="keywords" size="60" onchange="document.getElementById('keywordsFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:keywords"/></xsl:attribute>
								</input>
								<input type="hidden" name="keywordsFlag" value="0"/>	
							</td>
						</tr>
						<tr>
							<td>Short description</td>
							<td colspan="3">
								<input type="text" name="shortDesc" size="50" onchange="document.getElementById('shortDescFlag').value = 1">
									<xsl:attribute name="value"><xsl:value-of select=".//sql:shortDesc"/></xsl:attribute>
								</input>
								<input type="hidden" name="shortDescFlag" value="0"/>	
							</td>
							
			
						</tr>
						<tr>
							<td>Long description</td>
							<td colspan="3">
								<textarea rows="4" cols="50" onchange="document.getElementById('longDescFlag').value = 1" name="longDesc">
									<xsl:value-of select=".//sql:longdesc"/>
								</textarea>
								<input type="hidden" name="longDescFlag" value="0"/>	
							</td>
					</tr>
					<tr>
							<td>Author Biography</td>
							<td colspan="3">
								<textarea rows="4" cols="50" onchange="document.getElementById('authorBiographyFlag').value = 1" name="authorBiography">
									<xsl:value-of select=".//sql:authorbiography"/>
								</textarea>
								<input type="hidden" name="authorBiographyFlag" value="0"/>	
							</td>
						</tr>																
		
				<!-- rights -->
				<tr>
					<td>Rights</td>
					<td colspan="3">
						<input type="text" name="rights" size="50" onchange="document.getElementById('rightsFlag').value = 1">
							<xsl:attribute name="value"><xsl:value-of select=".//sql:rights"/></xsl:attribute>
						</input>
					</td>
					<input type="hidden" name="rightsFlag" value="0"/>	
				</tr>					


				<!-- Territory -->
				<tr>
					<td>Territory</td>
					<td colspan="3">
						<input type="text" name="territory" size="50" onchange="document.getElementById('territoryFlag').value = 1">
							<xsl:attribute name="value"><xsl:value-of select=".//sql:territory"/></xsl:attribute>
						</input>
					</td>
					<input type="hidden" name="territoryFlag" value="0"/>	
				</tr>				
		
					</tbody>
				</table>
							
				<script>
					<![CDATA[ 
					var printpubdate = new calendar2(document.forms['titleForm'].elements['printPubDate']);
					printpubdate.year_scroll = true;
					printpubdate.time_comp = false;
					]]>
				</script>

		</div>
	</xsl:template>
	

	<xsl:template match="formats">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="sql:row[ancestor::formats]">
		<xsl:variable name="formatAbbrev"><xsl:value-of select=".//sql:formatabbrev"/>_</xsl:variable>		
		
		<div class="formats" id="{.//sql:formatabbrev}">
					
			<!-- hidden value for each title format that exists -->
				<input type="hidden" name="fm">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:formatabbrev"/>_<xsl:value-of select=".//sql:titleformatid"/></xsl:attribute>
				</input> 				
					
		<table border="0" width="100%">
			<tbody>
			
		<!-- format 
		<tr>
	<td>Format</td>
			<td>
				<xsl:value-of select=".//sql:formatabbrev"/>

			</td>
		</tr>
		-->
		

				
		<!-- status -->
		<tr>
			<td>Status</td>
			<td>
				<xsl:variable name="currentabbr" select=".//sql:statusabbr"/>
				<select  name="{$formatAbbrev}currentStatus" onchange="document.getElementById('{$formatAbbrev}currentStatusFlag').value = 1;">
					<option>---</option>
					<xsl:for-each select="//statusCodes//sql:row">
						<xsl:choose>
							<xsl:when test="$currentabbr = sql:statusabbr">
								<option value="{sql:statusid}" selected="yes">
									<xsl:value-of select="sql:status"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option value="{sql:statusid}">
									<xsl:value-of select="sql:status"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>					
				</select>
				<input type="hidden" name="{$formatAbbrev}currentStatusFlag" value="0"/>
			</td>
		</tr>
		
		<!-- eISBN -->
		<tr>
			<td>eISBN</td>
			<td>
				<input type="text" name="{$formatAbbrev}eISBN"  onchange="document.getElementById('{$formatAbbrev}eISBNFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:eisbn"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}eISBNFlag"/>
			</td>
		</tr>
	
	
		<!-- 
			=========== DATES =========== 
		-->
	
	
		<tr>
			<td colspan="2">
				<div class="tablegrouphead">Customer Infomation</div>
			</td>
		</tr>
		
		
			<!-- customer -->
		<tr>
			<td>Customer</td>
			<td>
				<xsl:variable name="currentCustomer" select=".//sql:customerid"/>
				<select name="{$formatAbbrev}customerID" onchange="document.getElementById('{$formatAbbrev}customerIDFlag').value = 1">
					<option>---</option>
					<xsl:for-each select="//customers//sql:row">
						<xsl:choose>
							<xsl:when test="$currentCustomer = sql:customerid">
								<option value="{sql:customerid}" selected="yes">
									<xsl:value-of select="sql:customername"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option value="{sql:customerid}">
									<xsl:value-of select="sql:customername"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>					
				
				</select>
				<input type="hidden" name="{$formatAbbrev}customerIDFlag" value="0"/>			

			</td>
		</tr>

		<!-- customer dates -->
		<tr>
			<td>
			
				<div class="dateboxvisible" id="{$formatAbbrev}cd1">
					<div class="dateboxtitle">PDL Request DFC <img src="img/next.gif" onclick="nextDate(this.parentNode.id,2)"/></div>
					<div class="dateboxfield">
						<input type="text" name="{$formatAbbrev}requestDate">
							<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>requestDateFlag').value = 1</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select=".//sql:requestdate"/></xsl:attribute>
						</input>
						<a href="javascript:{$formatAbbrev}requestdate.popup();" onclick="document.getElementById('{$formatAbbrev}requestDateFlag').value = 1;">
							<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
						</a>
						<input type="hidden" name="{$formatAbbrev}requestDateFlag" value="0"/>					
					</div>
				</div>
				
				<div class="dateboxhidden"  id="{$formatAbbrev}cd2">
					<div class="dateboxtitle">Customer Request DTC <img src="img/next.gif" onclick="nextDate(this.parentNode.id,3)"/></div>
					<div class="dateboxfield">
						<input type="text" name="{$formatAbbrev}custRequestDate">
							<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>custRequestDateFlag').value = 1</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select=".//sql:custrequestdate"/></xsl:attribute>
						</input>
						<a href="javascript:{$formatAbbrev}custrequestdate.popup();" onclick="document.getElementById('{$formatAbbrev}custRequestDateFlag').value = 1;">
							<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
						</a>
						<input type="hidden" name="{$formatAbbrev}custRequestDateFlag" value="0"/>			
					</div>
				</div>
				
				<div class="dateboxhidden"  id="{$formatAbbrev}cd3">
					<div class="dateboxtitle">Customer Request OS</div>
					<div class="dateboxfield">
						<input type="text" name="{$formatAbbrev}pubDate">
							<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>pubDateFlag').value = 1</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select=".//sql:pubdate"/></xsl:attribute>
						</input>
						<a href="javascript:{$formatAbbrev}pubdate.popup();" onclick="document.getElementById('{$formatAbbrev}pubDateFlag').value = 1;">
							<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
						</a>
						<input type="hidden" name="{$formatAbbrev}pubDateFlag" value="0"/>			
					</div>
				</div>
				
			</td>
		</tr>








		<!-- intial receipt date --> 
		<tr style="border-top: 2px black solid">
			<td>Initial Receipt date</td>
			<td>
				<input type="text" name="{$formatAbbrev}initialReceiptDate">
					<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>initialReceiptDateFlag').value = 1</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select=".//sql:initialreceiptdate"/></xsl:attribute>
				</input>
					<a href="javascript:{$formatAbbrev}initialreceiptdate.popup();" onclick="document.getElementById('{$formatAbbrev}initialReceiptDateFlag').value = 1;">
					<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
				</a>
				<input type="hidden" name="{$formatAbbrev}initialReceiptDateFlag" value="0"/>			
			</td>
		</tr>



		<!-- plan ship date -->
		<tr>
			<td>Plan ship date</td>
			<td>
				<input type="text" name="{$formatAbbrev}planShipDate">
					<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>planShipDateFlag').value = 1</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select=".//sql:planshipdate"/></xsl:attribute>
				</input>
					<a href="javascript:{$formatAbbrev}planshipdate.popup();" onclick="document.getElementById('{$formatAbbrev}planShipDateFlag').value = 1;">
					<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
				</a>
				<input type="hidden" name="{$formatAbbrev}planShipDateFlag" value="0"/>			
			
			</td>
		</tr>

		<!-- shipped date -->
		<tr>
			<td>Shipped date</td>
			<td>
				<input type="text" name="{$formatAbbrev}shippedDate">
					<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>shippedDateFlag').value = 1</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select=".//sql:shippeddate"/></xsl:attribute>
				</input>
					<a href="javascript:{$formatAbbrev}shippeddate.popup();" onclick="document.getElementById('{$formatAbbrev}shippedDateFlag').value = 1;">
					<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
				</a>
				<input type="hidden" name="{$formatAbbrev}shippedDateFlag" value="0"/>			
			
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<div class="tablegrouphead">Conversion Infomation</div>
			</td>
		</tr>
		
		
		<!-- processingLocation -->
		<tr>
			<td>Processing Location</td>
			<td>
				<xsl:variable name="currentlocation" select=".//sql:processinglocation"/>
				<select  name="{$formatAbbrev}processingLocation" onchange="document.getElementById('{$formatAbbrev}processingLocationFlag').value = 1">
					<option>---</option>
					<xsl:for-each select="//locations//sql:row">
						<xsl:choose>
							<xsl:when test="$currentlocation = sql:locationid">
								<option value="{sql:locationid}" selected="yes">
									<xsl:value-of select="sql:locationname"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option value="{sql:locationid}">
									<xsl:value-of select="sql:locationname"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>					
				</select>
				<input type="hidden" name="{$formatAbbrev}processingLocationFlag" value="0"/>
			</td>

		</tr>

	
		<!-- conversion dates -->

		<!-- conversion receipt date --> 
		<tr>
			<td>Conversion Receipt date</td>
			<td>
				<input type="text" name="{$formatAbbrev}conversionReceiptDate">
					<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>conversionReceiptDateFlag').value = 1</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select=".//sql:conversionreceiptdate"/></xsl:attribute>
				</input>
					<a href="javascript:{$formatAbbrev}conversionreceiptdate.popup();" onclick="document.getElementById('{$formatAbbrev}conversionReceiptDateFlag').value = 1;">
					<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
				</a>
				<input type="hidden" name="{$formatAbbrev}conversionReceiptDateFlag" value="0"/>			
			</td>
		</tr>



			 
		<!-- plan receipt date --> 
		<tr>
			<td>Scheduled to PDL date</td>
			<td>
				<input type="text" name="{$formatAbbrev}planReceiptDate">
					<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>planReceiptDateFlag').value = 1</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select=".//sql:planreceiptdate"/></xsl:attribute>
				</input>
					<a href="javascript:{$formatAbbrev}planreceiptdate.popup();" onclick="document.getElementById('{$formatAbbrev}planReceiptDateFlag').value = 1;">
					<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
				</a>
				<input type="hidden" name="{$formatAbbrev}planReceiptDateFlag" value="0"/>			
			</td>
		</tr>
		
		<!-- receipt date -->
		<tr>
			<td>To PDL date</td>	
			<td>
				<input type="text" name="{$formatAbbrev}receiptDate">
					<xsl:attribute name="onchange">document.getElementById('<xsl:value-of select="$formatAbbrev"/>receiptDateFlag').value = 1</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select=".//sql:receiptdate"/></xsl:attribute>
				</input>
					<a href="javascript:{$formatAbbrev}receiptdate.popup();" onclick="document.getElementById('{$formatAbbrev}receiptDateFlag').value = 1;">
					<img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"/>
				</a>
				<input type="hidden" name="{$formatAbbrev}receiptDateFlag" value="0"/>			
			</td>
		</tr>


	
		<tr>
			<td colspan="2">
				<div class="tablegrouphead">Format infomation</div>
			</td>
		</tr>
		
		<!-- DOI -->
		<tr>
			<td>DOI</td>
			<td>
				<input type="text" name="{$formatAbbrev}DOI" onchange="document.getElementById('{$formatAbbrev}DOIFlag').value = 1">

					<xsl:attribute name="value"><xsl:value-of select=".//sql:doi"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}DOIFlag" value="0"/>
			</td>
		</tr>
		
		<!-- fileName -->
		<tr>
			<td>Filename</td>
			<td>
				<input type="text" name="{$formatAbbrev}filename" onchange="document.getElementById('{$formatAbbrev}filenameFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:filename"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}filenameFlag" value="0"/>
			</td>
		</tr>

		<!-- fileSize -->
		<tr>
			<td>File size</td>
			<td>
				<input type="text" name="{$formatAbbrev}fileSize" onchange="document.getElementById('{$formatAbbrev}fileSizeFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:filesize"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}fileSizeFlag" value="0"/>
			</td>
		</tr>

		<!-- inputFileType -->
		<tr>
			<td>Input file type</td>
			<td>
				<input type="text" name="{$formatAbbrev}inputFileType" onchange="document.getElementById('{$formatAbbrev}inputFileTypeFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:inputfiletype"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}inputFileTypeFlag" value="0"/>
			</td>
		</tr>
		
		<!-- suggestedRetailPrice 
		<tr>
			<td>Suggested retail price <br/> (format: 1234.56)</td>
			<td>
				<input type="text" name="{$formatAbbrev}suggestedRetailPrice" onchange="document.getElementById('{$formatAbbrev}suggestedRetailPriceFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:suggestedretailprice"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}suggestedRetailPriceFlag" value="0"/>
			</td>
		</tr>
		-->

		<!-- coverCount 
		<tr>
			<td>Cover image count</td>
			<td>
				<input type="text" name="{$formatAbbrev}coverCount" onchange="document.getElementById('{$formatAbbrev}coverCountFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:covercount"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}coverCountFlag" value="0"/>			
			</td>
		</tr>		
		-->

		<!-- imageCount 
		<tr>
			<td>Image count</td>
			<td>
				<input type="text" name="{$formatAbbrev}imageCount" onchange="document.getElementById('{$formatAbbrev}imageCountFlag').value = 1">
					<xsl:attribute name="value"><xsl:value-of select=".//sql:imagecount"/></xsl:attribute>
				</input>
				<input type="hidden" name="{$formatAbbrev}imageCountFlag" value="0"/>						
			</td>
		</tr>		
		-->

		<!-- remarks -->
		<tr>
			<td>Remarks</td>
			<td>
				<textarea rows="4" cols="50" onchange="document.getElementById('{$formatAbbrev}remarksFlag').value = 1" name="{$formatAbbrev}remarks">
					<xsl:value-of select=".//sql:remarks"/>
				</textarea>
				<input type="hidden" name="{$formatAbbrev}remarksFlag" value="0"/>	
			</td>
		</tr>					

		<!-- instructions -->
		<tr>
			<td>Instructions</td>
			<td>
				<textarea rows="4" cols="50" onchange="document.getElementById('{$formatAbbrev}instructionsFlag').value = 1" name="{$formatAbbrev}instructions">
					<xsl:value-of select=".//sql:instructions"/>
				</textarea>
				<input type="hidden" name="{$formatAbbrev}instructionsFlag" value="0"/>	
			</td>
		</tr>					

		<!-- rights -->
		<tr>
			<td>Rights</td>
			<td>
				<textarea rows="4" cols="50" onchange="document.getElementById('{$formatAbbrev}rightsFlag').value = 1" name="{$formatAbbrev}rights">
					<xsl:value-of select=".//sql:rights"/>
				</textarea>
				<input type="hidden" name="{$formatAbbrev}rightsFlag" value="0"/>	
			</td>
		</tr>					


		
			</tbody>
		</table>

		<script>

				var <xsl:value-of select="$formatAbbrev"/>conversionreceiptdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>conversionReceiptDate']);
				<xsl:value-of select="$formatAbbrev"/>conversionreceiptdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>conversionreceiptdate.time_comp = false;
		
				var <xsl:value-of select="$formatAbbrev"/>initialreceiptdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>initialReceiptDate']);
				<xsl:value-of select="$formatAbbrev"/>initialreceiptdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>initialreceiptdate.time_comp = false;

				var <xsl:value-of select="$formatAbbrev"/>requestdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>requestDate']);
				<xsl:value-of select="$formatAbbrev"/>requestdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>requestdate.time_comp = false;
			
				var <xsl:value-of select="$formatAbbrev"/>planreceiptdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>planReceiptDate']);
				<xsl:value-of select="$formatAbbrev"/>planreceiptdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>planreceiptdate.time_comp = false;

				var <xsl:value-of select="$formatAbbrev"/>receiptdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>receiptDate']);
				<xsl:value-of select="$formatAbbrev"/>receiptdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>receiptdate.time_comp = false;			

				var <xsl:value-of select="$formatAbbrev"/>custrequestdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>custRequestDate']);
				<xsl:value-of select="$formatAbbrev"/>custrequestdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>custrequestdate.time_comp = false;

				var <xsl:value-of select="$formatAbbrev"/>planshipdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>planShipDate']);
				<xsl:value-of select="$formatAbbrev"/>planshipdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>planshipdate.time_comp = false;
			
				var <xsl:value-of select="$formatAbbrev"/>shippeddate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>shippedDate']);
				<xsl:value-of select="$formatAbbrev"/>shippeddate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>shippeddate.time_comp = false;

				var <xsl:value-of select="$formatAbbrev"/>pubdate = new calendar2(document.forms['titleForm'].elements['<xsl:value-of select="$formatAbbrev"/>pubDate']);
				<xsl:value-of select="$formatAbbrev"/>pubdate.year_scroll = true;
				<xsl:value-of select="$formatAbbrev"/>pubdate.time_comp = false;			

		</script>


		</div>

	</xsl:template>


	<xsl:template name="showDate">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="$value = '2-11-30'">--</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
</xsl:stylesheet>
