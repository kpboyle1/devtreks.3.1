﻿<?xml version="1.0" encoding="UTF-8" ?>
<!-- Author: www.devtreks.org, 2013, November -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:y0="urn:DevTreks-support-schemas:Investment"
	xmlns:DisplayDevPacks="urn:displaydevpacks">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />
	<!-- pass in params -->
	<!-- what action is being taken by the server -->
	<xsl:param name="serverActionType" />
	<!-- what other action is being taken by the server -->
	<xsl:param name="serverSubActionType" />
	<!-- is the member viewing this uri the owner? -->
	<xsl:param name="isURIOwningClub" />
	<!-- which node to start with? -->
	<xsl:param name="nodeName" />
	<!-- which view to use? -->
	<xsl:param name="viewEditType" />
	<!-- is this a coordinator? -->
	<xsl:param name="memberRole" />
	<!-- what is the current uri? -->
	<xsl:param name="selectedFileURIPattern" />
	<!-- the addin being used -->
	<xsl:param name="calcDocURI" />
	<!-- the node being calculated-->
	<xsl:param name="docToCalcNodeName" />
	<!-- standard params used with calcs and custom docs -->
	<xsl:param name="calcParams" />
	<!-- what is the name of the node to be selected? -->
	<xsl:param name="selectionsNodeNeededName" />
	<!-- which network is this doc from? -->
	<xsl:param name="networkId" />
	<!-- what is the start row? -->
	<xsl:param name="startRow" />
	<!-- what is the end row? -->
	<xsl:param name="endRow" />
	<!-- what are the pagination properties ? -->
	<xsl:param name="pageParams" />
	<!-- what is the guide's email? -->
	<xsl:param name="clubEmail" />
	<!-- what is the current serviceid? -->
	<xsl:param name="contenturipattern" />
	<!-- path to resources -->
	<xsl:param name="fullFilePath" />
	<!-- init html -->
	<xsl:template match="@*|/|node()" />
	<xsl:template match="/">
		<xsl:apply-templates select="root" />
	</xsl:template>
	<xsl:template match="root">
		<div id="modEdits_divEditsDoc">
      <xsl:apply-templates select="servicebase" />
			<xsl:apply-templates select="investmentgroup" />
			<div>
				<a id="aFeedback" name="Feedback">
					<xsl:attribute name="href">mailto:<xsl:value-of select="$clubEmail" />?subject=<xsl:value-of select="$selectedFileURIPattern" /></xsl:attribute>
					Feedback About <xsl:value-of select="$selectedFileURIPattern" />
				</a>
      </div>
		</div>
	</xsl:template>
	<xsl:template match="servicebase">
		<h4 class="ui-bar-b">
			Service: <xsl:value-of select="@Name" />
		</h4>
		<xsl:apply-templates select="investmentgroup">
			<xsl:sort select="@Name"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmentgroup">
    <h4>
      <strong>Investment Group</strong> : <xsl:value-of select="@Name" />
    </h4>
		<xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
    <xsl:apply-templates select="investment">
			<xsl:sort select="@Date"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investment">
		<h4>
      <strong>Investment</strong> : <xsl:value-of select="@Name" />
    </h4>
		<xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
    <xsl:apply-templates select="investmenttimeperiod">
			<xsl:sort select="@Date"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmenttimeperiod">
		<h4>
      <strong>Time Period</strong> : <xsl:value-of select="@Name" />
    </h4>
    <xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
    <div>
      <strong>Outcomes</strong>
    </div>
		<xsl:apply-templates select="investmentoutcomes" />
    <div>
      <strong>Components</strong>
    </div>
		<xsl:apply-templates select="investmentcomponents" />
	</xsl:template>
	<xsl:template match="investmentoutcomes">
		<xsl:apply-templates select="investmentoutcome">
			<xsl:sort select="@Date"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmentoutcome">
		<h4>
      <strong>Outcome </strong> : <xsl:value-of select="@Name" />(Amount:&#xA0;<xsl:value-of select="@Amount" />;&#xA0;Date:&#xA0;<xsl:value-of select="@Date" />
    </h4>
		<xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
    <xsl:apply-templates select="investmentoutput">
    </xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmentoutput">
    <h4>
      <strong>Output </strong> : <xsl:value-of select="@Name" />
    </h4>
		<xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmentcomponents">
		<xsl:apply-templates select="investmentcomponent">
			<xsl:sort select="@Date"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmentcomponent">
		<h4>
      <strong>Component</strong> : <xsl:value-of select="@Name" />
    </h4>
		<xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
    <xsl:apply-templates select="investmentinput">
    </xsl:apply-templates>
	</xsl:template>
	<xsl:template match="investmentinput">
		<h4>
      <strong>Input </strong> : <xsl:value-of select="@Name" />
    </h4>
		<xsl:apply-templates select="root/linkedview[@AnalyzerType='lcastat1']">
			<xsl:with-param name="localName"><xsl:value-of select="local-name()" /></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="root/linkedview">
		<xsl:param name="localName" />
		<xsl:if test="($localName != 'investmentinput' and $localName != 'investmentoutput')">
      <xsl:if test="($localName != 'investmentcomponent')">
        <div data-role="collapsible" data-collapsed="false" data-theme="b" data-content-theme="d" >
          <h4 class="ui-bar-b">
            <strong>Benefit Details</strong>
          </h4>
          <div class="ui-grid-a">
          <div class="ui-block-a">
            Benefit Observations : <xsl:value-of select="@TBenefitN"/>
          </div>
          <div class="ui-block-b">
          </div>
          <div class="ui-block-a">
            Benefit Total : <xsl:value-of select="@TRBenefit"/>
          </div>
          <div class="ui-block-b">
            Benefit Mean : <xsl:value-of select="@TRMean"/>
          </div>
          <div class="ui-block-a">
            Benefit Median : <xsl:value-of select="@TRMedian"/>
          </div>
          <div class="ui-block-b">
            Benefit Variance : <xsl:value-of select="@TRVariance"/>
          </div>
          <div class="ui-block-a">
            Benefit Std Dev : <xsl:value-of select="@TRStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            LCB Total : <xsl:value-of select="@TLCBBenefit"/>
          </div>
          <div class="ui-block-b">
            LCB Mean : <xsl:value-of select="@TLCBMean"/>
          </div>
          <div class="ui-block-a">
            LCB Median : <xsl:value-of select="@TLCBMedian"/>
          </div>
          <div class="ui-block-b">
            LCB Variance : <xsl:value-of select="@TLCBVariance"/>
          </div>
          <div class="ui-block-a">
            LCB Std Dev : <xsl:value-of select="@TLCBStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            EAA Total : <xsl:value-of select="@TREAABenefit"/>
          </div>
          <div class="ui-block-b">
            EAA Mean : <xsl:value-of select="@TREAAMean"/>
          </div>
          <div class="ui-block-a">
            EAA Median : <xsl:value-of select="@TREAAMedian"/>
          </div>
          <div class="ui-block-b">
            EAA Variance : <xsl:value-of select="@TREAAVariance"/>
          </div>
          <div class="ui-block-a">
            EAA Std Dev : <xsl:value-of select="@TREAAStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            Unit Total : <xsl:value-of select="@TRUnitBenefit"/>
          </div>
          <div class="ui-block-b">
            Unit Mean : <xsl:value-of select="@TRUnitMean"/>
          </div>
          <div class="ui-block-a">
            Unit Median : <xsl:value-of select="@TRUnitMedian"/>
          </div>
          <div class="ui-block-b">
            Unit Variance : <xsl:value-of select="@TRUnitVariance"/>
          </div>
          <div class="ui-block-a">
            Unit Std Dev : <xsl:value-of select="@TRUnitStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
        </div>
        </div>
      </xsl:if>
      <xsl:if test="($localName != 'investmentoutcome')">
        <div data-role="collapsible" data-collapsed="false" data-theme="b" data-content-theme="d" >
        <h4 class="ui-bar-b">
          <strong>Cost Details</strong>
        </h4>
        <div class="ui-grid-a">
          <div class="ui-block-a">
            Cost Observations : <xsl:value-of select="@TCostN"/>
          </div>
          <div class="ui-block-b">
          </div>
          <div class="ui-block-a">
            OC Total : <xsl:value-of select="@TOCCost"/>
          </div>
          <div class="ui-block-b">
            OC Mean : <xsl:value-of select="@TOCMean"/>
          </div>
          <div class="ui-block-a">
            OC Median : <xsl:value-of select="@TOCMedian"/>
          </div>
          <div class="ui-block-b">
            OC Variance : <xsl:value-of select="@TOCVariance"/>
          </div>
          <div class="ui-block-a">
            OC Std Dev : <xsl:value-of select="@TOCStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            AOH Total : <xsl:value-of select="@TAOHCost"/>
          </div>
          <div class="ui-block-b">
            AOH Mean : <xsl:value-of select="@TAOHMean"/>
          </div>
          <div class="ui-block-a">
            AOH Median : <xsl:value-of select="@TAOHMedian"/>
          </div>
          <div class="ui-block-b">
            AOH Variance : <xsl:value-of select="@TAOHVariance"/>
          </div>
          <div class="ui-block-a">
            AOH Std Dev : <xsl:value-of select="@TAOHStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            CAP Total : <xsl:value-of select="@TCAPCost"/>
          </div>
          <div class="ui-block-b">
            CAP Mean : <xsl:value-of select="@TCAPMean"/>
          </div>
          <div class="ui-block-a">
            CAP Median : <xsl:value-of select="@TCAPMedian"/>
          </div>
          <div class="ui-block-b">
            CAP Variance : <xsl:value-of select="@TCAPVariance"/>
          </div>
          <div class="ui-block-a">
            CAP Std Dev : <xsl:value-of select="@TCAPStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            LCC Total : <xsl:value-of select="@TLCCCost"/>
          </div>
          <div class="ui-block-b">
            LCC Mean : <xsl:value-of select="@TLCCMean"/>
          </div>
          <div class="ui-block-a">
            LCC Median : <xsl:value-of select="@TLCCMedian"/>
          </div>
          <div class="ui-block-b">
            LCC Variance : <xsl:value-of select="@TLCCVariance"/>
          </div>
          <div class="ui-block-a">
            LCC Std Dev : <xsl:value-of select="@TLCCStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            EAA Total : <xsl:value-of select="@TEAACost"/>
          </div>
          <div class="ui-block-b">
            EAA Mean : <xsl:value-of select="@TEAAMean"/>
          </div>
          <div class="ui-block-a">
            EAA Median : <xsl:value-of select="@TEAAMedian"/>
          </div>
          <div class="ui-block-b">
            EAA Variance : <xsl:value-of select="@TEAAVariance"/>
          </div>
          <div class="ui-block-a">
            EAA Std Dev : <xsl:value-of select="@TEAAStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
          <div class="ui-block-a">
            Unit Total : <xsl:value-of select="@TUnitCost"/>
          </div>
          <div class="ui-block-b">
            Unit Mean : <xsl:value-of select="@TUnitMean"/>
          </div>
          <div class="ui-block-a">
            Unit Median : <xsl:value-of select="@TUnitMedian"/>
          </div>
          <div class="ui-block-b">
            Unit Variance : <xsl:value-of select="@TUnitVariance"/>
          </div>
          <div class="ui-block-a">
            Unit Std Dev : <xsl:value-of select="@TUnitStandDev"/>
          </div>
          <div class="ui-block-b">    
          </div>
        </div>
      </div>
      </xsl:if>
		</xsl:if>
		<xsl:if test="($localName = 'investmentinput')">
			<div data-role="collapsible"  data-theme="b" data-content-theme="d" >
        <h4 class="ui-bar-b">
          <strong>Input Details</strong>
        </h4>
        <div class="ui-grid-a">
          <div class="ui-block-a">
           Total OC : <xsl:value-of select="@TOCCost"/>
          </div>
          <div class="ui-block-b">
            Total AOH : <xsl:value-of select="@TAOHCost"/>
          </div>
          <div class="ui-block-a">
            Total CAP : <xsl:value-of select="@TCAPCost"/>
          </div>
          <div class="ui-block-b">
           Total LCC : <xsl:value-of select="@TLCCCost"/>
          </div>
          <div class="ui-block-b">
            Total Unit : <xsl:value-of select="@TUnitCost"/>
          </div>
          <div class="ui-block-a">
            Total EAA : <xsl:value-of select="@TEAACost"/>
          </div>
          <div class="ui-block-b">
          </div>
        </div>
      </div>
		</xsl:if>
    <xsl:if test="($localName = 'investmentoutput')">
			<div data-role="collapsible"  data-theme="b" data-content-theme="d" >
        <h4 class="ui-bar-b">
          <strong>Output Details</strong>
        </h4>
        <div class="ui-grid-a">
          <div class="ui-block-a">
            Total Revenue : <xsl:value-of select="@TRBenefit"/>
          </div>
          <div class="ui-block-b">
            Total LCB : <xsl:value-of select="@TLCBBenefit"/>
          </div>
          <div class="ui-block-a">
            Total EAA : <xsl:value-of select="@TREAABenefit"/>
          </div>
          <div class="ui-block-b">
            Total Unit : <xsl:value-of select="@TRUnitBenefit"/>
          </div>
        </div>
      </div>
		</xsl:if>
    <xsl:if test="($localName != 'investmentoutcome' and $localName != 'investmentoutput')">
    <div data-role="collapsible" data-collapsed="true" data-theme="b" data-content-theme="d" >
      <h4 class="ui-bar-b">
        <strong>SubCosts</strong>
      </h4>
      <div class="ui-grid-a">
        <xsl:if test="(@TSubP1Name1 != '' and @TSubP1Name1 != 'none')">
          <div class="ui-block-a">
            SubCost 1 Name :  <xsl:value-of select="@TSubP1Name1"/>
          </div>
          <div class="ui-block-b">
            SubCost 1 Amount : <xsl:value-of select="@TSubP1Amount1"/>
          </div>
          <div class="ui-block-a">
            SubCost 1 Unit :  <xsl:value-of select="@TSubP1Unit1"/>
          </div>
          <div class="ui-block-b">
            SubCost 1 Price : <xsl:value-of select="@TSubP1Price1"/>
          </div>
          <div class="ui-block-a">
            SubCost 1 Total : <xsl:value-of select="@TSubP1Total1"/>
          </div>
          <div class="ui-block-b">
            SubCost 1 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit1"/>
          </div>
          <div class="ui-block-a">
            SubCost 1 Description :  <xsl:value-of select="@TSubP1Description1"/>
          </div>
          <div class="ui-block-b">
            SubCost 1 Label :  <xsl:value-of select="@TSubP1Label1"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name2 != '' and @TSubP1Name2 != 'none')">
          <div class="ui-block-a">
            SubCost 2 Name :  <xsl:value-of select="@TSubP1Name2"/>
          </div>
          <div class="ui-block-b">
            SubCost 2 Amount : <xsl:value-of select="@TSubP1Amount2"/>
          </div>
          <div class="ui-block-a">
            SubCost 2 Unit :  <xsl:value-of select="@TSubP1Unit2"/>
          </div>
          <div class="ui-block-b">
            SubCost 2 Price : <xsl:value-of select="@TSubP1Price2"/>
          </div>
          <div class="ui-block-a">
            SubCost 2 Total : <xsl:value-of select="@TSubP1Total2"/>
          </div>
          <div class="ui-block-b">
            SubCost 2 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit2"/>
          </div>
          <div class="ui-block-a">
            SubCost 2 Description :  <xsl:value-of select="@TSubP1Description2"/>
          </div>
          <div class="ui-block-b">
            SubCost 2 Label :  <xsl:value-of select="@TSubP1Label2"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name3 != '' and @TSubP1Name3 != 'none')">
          <div class="ui-block-a">
            SubCost 3 Name :  <xsl:value-of select="@TSubP1Name3"/>
          </div>
          <div class="ui-block-b">
            SubCost 3 Amount : <xsl:value-of select="@TSubP1Amount3"/>
          </div>
          <div class="ui-block-a">
            SubCost 3 Unit :  <xsl:value-of select="@TSubP1Unit3"/>
          </div>
          <div class="ui-block-b">
            SubCost 3 Price : <xsl:value-of select="@TSubP1Price3"/>
          </div>
          <div class="ui-block-a">
            SubCost 3 Total : <xsl:value-of select="@TSubP1Total3"/>
          </div>
          <div class="ui-block-b">
            SubCost 3 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit3"/>
          </div>
          <div class="ui-block-a">
            SubCost 3 Description :  <xsl:value-of select="@TSubP1Description3"/>
          </div>
          <div class="ui-block-b">
            SubCost 3 Label :  <xsl:value-of select="@TSubP1Label3"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name4 != '' and @TSubP1Name4 != 'none')">
          <div class="ui-block-a">
            SubCost 4 Name :  <xsl:value-of select="@TSubP1Name4"/>
          </div>
          <div class="ui-block-b">
            SubCost 4 Amount : <xsl:value-of select="@TSubP1Amount4"/>
          </div>
          <div class="ui-block-a">
            SubCost 4 Unit :  <xsl:value-of select="@TSubP1Unit4"/>
          </div>
          <div class="ui-block-b">
            SubCost 4 Price : <xsl:value-of select="@TSubP1Price4"/>
          </div>
          <div class="ui-block-a">
            SubCost 4 Total : <xsl:value-of select="@TSubP1Total4"/>
          </div>
          <div class="ui-block-b">
            SubCost 4 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit4"/>
          </div>
          <div class="ui-block-a">
            SubCost 4 Description :  <xsl:value-of select="@TSubP1Description4"/>
          </div>
          <div class="ui-block-b">
            SubCost 4 Label :  <xsl:value-of select="@TSubP1Label4"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name5 != '' and @TSubP1Name5 != 'none')">
          <div class="ui-block-a">
            SubCost 5 Name :  <xsl:value-of select="@TSubP1Name5"/>
          </div>
          <div class="ui-block-b">
            SubCost 5 Amount : <xsl:value-of select="@TSubP1Amount5"/>
          </div>
          <div class="ui-block-a">
            SubCost 5 Unit :  <xsl:value-of select="@TSubP1Unit5"/>
          </div>
          <div class="ui-block-b">
            SubCost 5 Price : <xsl:value-of select="@TSubP1Price5"/>
          </div>
          <div class="ui-block-a">
            SubCost 5 Total : <xsl:value-of select="@TSubP1Total5"/>
          </div>
          <div class="ui-block-b">
            SubCost 5 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit5"/>
          </div>
          <div class="ui-block-a">
            SubCost 5 Description :  <xsl:value-of select="@TSubP1Description5"/>
          </div>
          <div class="ui-block-b">
            SubCost 5 Label :  <xsl:value-of select="@TSubP1Label5"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name6 != '' and @TSubP1Name6 != 'none')">
          <div class="ui-block-a">
            SubCost 6 Name :  <xsl:value-of select="@TSubP1Name6"/>
          </div>
          <div class="ui-block-b">
            SubCost 6 Amount : <xsl:value-of select="@TSubP1Amount6"/>
          </div>
          <div class="ui-block-a">
            SubCost 6 Unit :  <xsl:value-of select="@TSubP1Unit6"/>
          </div>
          <div class="ui-block-b">
            SubCost 6 Price : <xsl:value-of select="@TSubP1Price6"/>
          </div>
          <div class="ui-block-a">
            SubCost 6 Total : <xsl:value-of select="@TSubP1Total6"/>
          </div>
          <div class="ui-block-b">
            SubCost 6 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit6"/>
          </div>
          <div class="ui-block-a">
            SubCost 6 Description :  <xsl:value-of select="@TSubP1Description6"/>
          </div>
          <div class="ui-block-b">
            SubCost 6 Label :  <xsl:value-of select="@TSubP1Label6"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name7 != '' and @TSubP1Name7 != 'none')">
          <div class="ui-block-a">
            SubCost 7 Name :  <xsl:value-of select="@TSubP1Name7"/>
          </div>
          <div class="ui-block-b">
            SubCost 7 Amount : <xsl:value-of select="@TSubP1Amount7"/>
          </div>
          <div class="ui-block-a">
            SubCost 7 Unit :  <xsl:value-of select="@TSubP1Unit7"/>
          </div>
          <div class="ui-block-b">
            SubCost 7 Price : <xsl:value-of select="@TSubP1Price7"/>
          </div>
          <div class="ui-block-a">
            SubCost 7 Total : <xsl:value-of select="@TSubP1Total7"/>
          </div>
          <div class="ui-block-b">
            SubCost 7 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit7"/>
          </div>
          <div class="ui-block-a">
            SubCost 7 Description :  <xsl:value-of select="@TSubP1Description7"/>
          </div>
          <div class="ui-block-b">
            SubCost 7 Label :  <xsl:value-of select="@TSubP1Label7"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name8 != '' and @TSubP1Name8 != 'none')">
          <div class="ui-block-a">
            SubCost 8 Name :  <xsl:value-of select="@TSubP1Name8"/>
          </div>
          <div class="ui-block-b">
            SubCost 8 Amount : <xsl:value-of select="@TSubP1Amount8"/>
          </div>
          <div class="ui-block-a">
            SubCost 8 Unit :  <xsl:value-of select="@TSubP1Unit8"/>
          </div>
          <div class="ui-block-b">
            SubCost 8 Price : <xsl:value-of select="@TSubP1Price8"/>
          </div>
          <div class="ui-block-a">
            SubCost 8 Total : <xsl:value-of select="@TSubP1Total8"/>
          </div>
          <div class="ui-block-b">
            SubCost 8 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit8"/>
          </div>
          <div class="ui-block-a">
            SubCost 8 Description :  <xsl:value-of select="@TSubP1Description8"/>
          </div>
          <div class="ui-block-b">
            SubCost 8 Label :  <xsl:value-of select="@TSubP1Label8"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name9 != '' and @TSubP1Name9 != 'none')">
          <div class="ui-block-a">
            SubCost 9 Name :  <xsl:value-of select="@TSubP1Name9"/>
          </div>
          <div class="ui-block-b">
            SubCost 9 Amount : <xsl:value-of select="@TSubP1Amount9"/>
          </div>
          <div class="ui-block-a">
            SubCost 9 Unit :  <xsl:value-of select="@TSubP1Unit9"/>
          </div>
          <div class="ui-block-b">
            SubCost 9 Price : <xsl:value-of select="@TSubP1Price9"/>
          </div>
          <div class="ui-block-a">
            SubCost 9 Total : <xsl:value-of select="@TSubP1Total9"/>
          </div>
          <div class="ui-block-b">
            SubCost 9 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit9"/>
          </div>
          <div class="ui-block-a">
            SubCost 9 Description :  <xsl:value-of select="@TSubP1Description9"/>
          </div>
          <div class="ui-block-b">
            SubCost 9 Label :  <xsl:value-of select="@TSubP1Label9"/>
          </div>
        </xsl:if>
        <xsl:if test="(@TSubP1Name10 != '' and @TSubP1Name10 != 'none')">
          <div class="ui-block-a">
            SubCost 10 Name :  <xsl:value-of select="@TSubP1Name10"/>
          </div>
          <div class="ui-block-b">
            SubCost 10 Amount : <xsl:value-of select="@TSubP1Amount10"/>
          </div>
          <div class="ui-block-a">
            SubCost 10 Unit :  <xsl:value-of select="@TSubP1Unit10"/>
          </div>
          <div class="ui-block-b">
            SubCost 10 Price : <xsl:value-of select="@TSubP1Price10"/>
          </div>
          <div class="ui-block-a">
            SubCost 10 Total : <xsl:value-of select="@TSubP1Total10"/>
          </div>
          <div class="ui-block-b">
            SubCost 10 Unit Cost : <xsl:value-of select="@TSubP1TotalPerUnit10"/>
          </div>
          <div class="ui-block-a">
            SubCost 10 Description :  <xsl:value-of select="@TSubP1Description10"/>
          </div>
          <div class="ui-block-b">
            SubCost 10 Label :  <xsl:value-of select="@TSubP1Label10"/>
          </div>
        </xsl:if>
      </div>
    </div>
    </xsl:if>
    <xsl:if test="($localName != 'investmentcomponent' and $localName != 'investmentinput')">
    <div data-role="collapsible" data-collapsed="true" data-theme="b" data-content-theme="d" >
      <h4 class="ui-bar-b">
        <strong>SubBenefits</strong>
      </h4>
      <div class="ui-grid-a">
         <xsl:if test="(@TSubP2Name1 != '' and @TSubP2Name1 != 'none')">
            <div class="ui-block-a">
              SubBen 1 Name :  <xsl:value-of select="@TSubP2Name1"/>
            </div>
            <div class="ui-block-b">
              SubBen 1 Amount : <xsl:value-of select="@TSubP2Amount1"/>
            </div>
            <div class="ui-block-a">
              SubBen 1 Unit : <xsl:value-of select="@TSubP2Unit1"/>
            </div>
            <div class="ui-block-b">
              SubBen 1 Price : <xsl:value-of select="@TSubP2Price1"/>
            </div>
            <div class="ui-block-a">
              SubBen 1 Total : <xsl:value-of select="@TSubP2Total1"/>
            </div>
            <div class="ui-block-b">
              SubBen 1 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit1"/>
            </div>
            <div class="ui-block-a">
              SubBen 1 Description :  <xsl:value-of select="@TSubP2Description1"/>
            </div>
            <div class="ui-block-b">
              SubBen 1 Label :  <xsl:value-of select="@TSubP2Label1"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name2 != '' and @TSubP2Name2 != 'none')">
            <div class="ui-block-a">
              SubBen 2 Name :  <xsl:value-of select="@TSubP2Name2"/>
            </div>
            <div class="ui-block-b">
              SubBen 2 Amount : <xsl:value-of select="@TSubP2Amount2"/>
            </div>
            <div class="ui-block-a">
             SubBen 2 Unit : <xsl:value-of select="@TSubP2Unit2"/>
            </div>
            <div class="ui-block-b">
              SubBen 2 Price : <xsl:value-of select="@TSubP2Price2"/>
            </div>
            <div class="ui-block-a">
              SubBen 2 Total : <xsl:value-of select="@TSubP2Total2"/>
            </div>
            <div class="ui-block-b">
              SubBen 2 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit2"/>
            </div>
            <div class="ui-block-a">
              SubBen 2 Description :  <xsl:value-of select="@TSubP2Description2"/>
            </div>
            <div class="ui-block-b">
              SubBen 2 Label :  <xsl:value-of select="@TSubP2Label2"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name3 != '' and @TSubP2Name3 != 'none')">
            <div class="ui-block-a">
              SubBen 3 Name :  <xsl:value-of select="@TSubP2Name3"/>
            </div>
            <div class="ui-block-b">
              SubBen 3 Amount : <xsl:value-of select="@TSubP2Amount3"/>
            </div>
            <div class="ui-block-a">
              SubBen 3 Unit : <xsl:value-of select="@TSubP2Unit3"/>
            </div>
            <div class="ui-block-b">
              SubBen 3 Price : <xsl:value-of select="@TSubP2Price3"/>
            </div>
            <div class="ui-block-a">
              SubBen 3 Total : <xsl:value-of select="@TSubP2Total3"/>
            </div>
            <div class="ui-block-b">
              SubBen 3 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit3"/>
            </div>
            <div class="ui-block-a">
              SubBen 3 Description :  <xsl:value-of select="@TSubP2Description3"/>
            </div>
            <div class="ui-block-b">
              SubBen 3 Label :  <xsl:value-of select="@TSubP2Label3"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name4 != '' and @TSubP2Name4 != 'none')">
            <div class="ui-block-a">
              SubBen 4 Name :  <xsl:value-of select="@TSubP2Name4"/>
            </div>
            <div class="ui-block-b">
              SubBen 4 Amount : <xsl:value-of select="@TSubP2Amount4"/>
            </div>
            <div class="ui-block-a">
             SubBen 4 Unit : <xsl:value-of select="@TSubP2Unit4"/>
            </div>
            <div class="ui-block-b">
              SubBen 4 Price : <xsl:value-of select="@TSubP2Price4"/>
            </div>
            <div class="ui-block-a">
              SubBen 4 Total : <xsl:value-of select="@TSubP2Total4"/>
            </div>
            <div class="ui-block-b">
              SubBen 4 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit4"/>
            </div>
            <div class="ui-block-a">
              SubBen 4 Description :  <xsl:value-of select="@TSubP2Description4"/>
            </div>
            <div class="ui-block-b">
              SubBen 4 Label :  <xsl:value-of select="@TSubP2Label4"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name5 != '' and @TSubP2Name5 != 'none')">
            <div class="ui-block-a">
              SubBen 5 Name :  <xsl:value-of select="@TSubP2Name5"/>
            </div>
            <div class="ui-block-b">
              SubBen 5 Amount : <xsl:value-of select="@TSubP2Amount5"/>
            </div>
            <div class="ui-block-a">
              SubBen 5 Unit : <xsl:value-of select="@TSubP2Unit5"/>
            </div>
            <div class="ui-block-b">
              SubBen 5 Price : <xsl:value-of select="@TSubP2Price5"/>
            </div>
            <div class="ui-block-a">
              SubBen 5 Total : <xsl:value-of select="@TSubP2Total5"/>
            </div>
            <div class="ui-block-b">
              SubBen 5 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit5"/>
            </div>
            <div class="ui-block-a">
              SubBen 5 Description :  <xsl:value-of select="@TSubP2Description5"/>
            </div>
            <div class="ui-block-b">
              SubBen 5 Label :  <xsl:value-of select="@TSubP2Label5"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name6 != '' and @TSubP2Name6 != 'none')">
            <div class="ui-block-a">
              SubBen 6 Name :  <xsl:value-of select="@TSubP2Name6"/>
            </div>
            <div class="ui-block-b">
              SubBen 6 Amount : <xsl:value-of select="@TSubP2Amount6"/>
            </div>
            <div class="ui-block-a">
             SubBen 6 Unit : <xsl:value-of select="@TSubP2Unit6"/>
            </div>
            <div class="ui-block-b">
              SubBen 6 Price : <xsl:value-of select="@TSubP2Price6"/>
            </div>
            <div class="ui-block-a">
              SubBen 6 Total : <xsl:value-of select="@TSubP2Total6"/>
            </div>
            <div class="ui-block-b">
              SubBen 6 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit6"/>
            </div>
            <div class="ui-block-a">
              SubBen 6 Description :  <xsl:value-of select="@TSubP2Description6"/>
            </div>
            <div class="ui-block-b">
              SubBen 6 Label :  <xsl:value-of select="@TSubP2Label6"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name7 != '' and @TSubP2Name7 != 'none')">
            <div class="ui-block-a">
              SubBen 7 Name :  <xsl:value-of select="@TSubP2Name7"/>
            </div>
            <div class="ui-block-b">
              SubBen 7 Amount : <xsl:value-of select="@TSubP2Amount7"/>
            </div>
            <div class="ui-block-a">
              SubBen 7 Unit : <xsl:value-of select="@TSubP2Unit7"/>
            </div>
            <div class="ui-block-b">
              SubBen 7 Price : <xsl:value-of select="@TSubP2Price7"/>
            </div>
            <div class="ui-block-a">
              SubBen 7 Total : <xsl:value-of select="@TSubP2Total7"/>
            </div>
            <div class="ui-block-b">
              SubBen 7 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit7"/>
            </div>
            <div class="ui-block-a">
              SubBen 7 Description :  <xsl:value-of select="@TSubP2Description7"/>
            </div>
            <div class="ui-block-b">
              SubBen 7 Label :  <xsl:value-of select="@TSubP2Label7"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name8 != '' and @TSubP2Name8 != 'none')">
            <div class="ui-block-a">
              SubBen 8 Name :  <xsl:value-of select="@TSubP2Name8"/>
            </div>
            <div class="ui-block-b">
              SubBen 8 Amount : <xsl:value-of select="@TSubP2Amount8"/>
            </div>
            <div class="ui-block-a">
              SubBen 8 Unit : <xsl:value-of select="@TSubP2Unit8"/>
            </div>
            <div class="ui-block-b">
              SubBen 8 Price : <xsl:value-of select="@TSubP2Price8"/>
            </div>
            <div class="ui-block-a">
              SubBen 8 Total : <xsl:value-of select="@TSubP2Total8"/>
            </div>
            <div class="ui-block-b">
              SubBen 8 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit8"/>
            </div>
            <div class="ui-block-a">
              SubBen 8 Description :  <xsl:value-of select="@TSubP2Description8"/>
            </div>
            <div class="ui-block-b">
              SubBen 8 Label :  <xsl:value-of select="@TSubP2Label8"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name9 != '' and @TSubP2Name9 != 'none')">
            <div class="ui-block-a">
              SubBen 9 Name :  <xsl:value-of select="@TSubP2Name9"/>
            </div>
            <div class="ui-block-b">
              SubBen 9 Amount : <xsl:value-of select="@TSubP2Amount9"/>
            </div>
            <div class="ui-block-a">
              SubBen 9 Unit : <xsl:value-of select="@TSubP2Unit9"/>
            </div>
            <div class="ui-block-b">
              SubBen 9 Price : <xsl:value-of select="@TSubP2Price9"/>
            </div>
            <div class="ui-block-a">
              SubBen 9 Total : <xsl:value-of select="@TSubP2Total9"/>
            </div>
            <div class="ui-block-b">
              SubBen 9 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit9"/>
            </div>
            <div class="ui-block-a">
              SubBen 9 Description :  <xsl:value-of select="@TSubP2Description9"/>
            </div>
            <div class="ui-block-b">
              SubBen 9 Label :  <xsl:value-of select="@TSubP2Label9"/>
            </div>
          </xsl:if>
          <xsl:if test="(@TSubP2Name10 != '' and @TSubP2Name10 != 'none')">
            <div class="ui-block-a">
              SubBen 10 Name :  <xsl:value-of select="@TSubP2Name10"/>
            </div>
            <div class="ui-block-b">
              SubBen 10 Amount : <xsl:value-of select="@TSubP2Amount10"/>
            </div>
            <div class="ui-block-a">
              SubBen 10 Unit : <xsl:value-of select="@TSubP2Unit10"/>
            </div>
            <div class="ui-block-b">
              SubBen 10 Price : <xsl:value-of select="@TSubP2Price10"/>
            </div>
            <div class="ui-block-a">
              SubBen 10 Total : <xsl:value-of select="@TSubP2Total10"/>
            </div>
            <div class="ui-block-b">
              SubBen 10 Unit Benefit : <xsl:value-of select="@TSubP2TotalPerUnit10"/>
            </div>
            <div class="ui-block-a">
              SubBen 10 Description :  <xsl:value-of select="@TSubP2Description10"/>
            </div>
            <div class="ui-block-b">
              SubBen 10 Label :  <xsl:value-of select="@TSubP2Label10"/>
            </div>
          </xsl:if>
      </div>
    </div>
    </xsl:if>
    <div >
			  <strong>Description : </strong><xsl:value-of select="@CalculatorDescription" />
	    </div>
	</xsl:template>
</xsl:stylesheet>
