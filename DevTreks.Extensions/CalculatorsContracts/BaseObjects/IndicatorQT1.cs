using System.Collections.Generic;
using System.Linq;

namespace DevTreks.Extensions
{
    ///<summary>
    ///Purpose:		Use a generic SB1Base indicator object to hold the results of algorithms. 
    ///             The algorithm results are passed back to SB1Base-based objects, 
    ///             who then fill in the original SB1Base with the results. 
    ///Author:		www.devtreks.org
    ///Date:		2020, March
    ///NOTES        1. Most data manipulation takes place using the collection property.
    ///             2. By convention, the first member of a this collection is the Score, and the 
    ///             remaining are the indexed Indicators.
    ///             v220 increased indicator props to 30 so that TEXT files 
    ///             could have a 1 to 1 relation to TEXT factor props 
    ///             as a reasonable substitute for formal property names
    ///             factor1 = IndicatorQT.Q1; factor30 = IndicatorQT.Q30
    /// </summary>
    public class IndicatorQT1 : Calculator1
    {
        public IndicatorQT1()
            : base()
        {
            InitCalculatorProperties();
            InitIndicatorQT1sProperties();
        }
        public IndicatorQT1(Calculator1 calculator, string label, 
            double qTM, double qTL, double qTU, double qT, double qTD1, double qTD2,
            string qTMUnit, string qTLUnit, string qTUUnit, string qTUnit, string qTD1Unit, string qTD2Unit,
            string qMathType, string qMathSubType, string qDistributionType,
            string qMathExpression, string qMathResult,
            double q1, double q2, double q3, double q4, double q5,
            string q1Unit, string q2Unit, string q3Unit, string q4Unit, string q5Unit)
            : base(calculator)
        {
            this.Label = label;
            this.QTM = CalculatorHelpers.CheckForNaNandRound4(qTM);
            this.QTL = CalculatorHelpers.CheckForNaNandRound4(qTL);
            this.QTU = CalculatorHelpers.CheckForNaNandRound4(qTU);
            this.QT = CalculatorHelpers.CheckForNaNandRound4(qT);
            this.QTD1 = CalculatorHelpers.CheckForNaNandRound4(qTD1);
            this.QTD2 = CalculatorHelpers.CheckForNaNandRound4(qTD2);
            this.QTMUnit = qTMUnit;
            this.QTLUnit = qTLUnit;
            this.QTUUnit = qTUUnit;
            this.QTUnit = qTUnit;
            this.QTD1Unit = qTD1Unit;
            this.QTD2Unit = qTD2Unit;
            this.QMathType = qMathType;
            this.QMathSubType = qMathSubType;
            this.QDistributionType = qDistributionType;
            this.QMathExpression = qMathExpression;
            this.MathResult = qMathResult;
            this.Q1 = CalculatorHelpers.CheckForNaNandRound4(q1);
            this.Q1Unit = q1Unit;
            this.Q2 = CalculatorHelpers.CheckForNaNandRound4(q2);
            this.Q2Unit = q2Unit;
            this.Q3 = CalculatorHelpers.CheckForNaNandRound4(q3);
            this.Q3Unit = q3Unit;
            this.Q4 = CalculatorHelpers.CheckForNaNandRound4(q4);
            this.Q4Unit = q4Unit;
            this.Q5 = CalculatorHelpers.CheckForNaNandRound4(q5);
            this.Q5Unit = q5Unit;
            //210 added q6 to q11 for supplemental storage (not because UI changed)
            this.Indicators = new string[] { };
        }
        //copy constructor (base added for ml algos)
        public IndicatorQT1(IndicatorQT1 indQT1)
        :base(indQT1)
        {
            CopyIndicatorQT1sProperties(indQT1);
        }
        //properties
        //list of IndicatorQT1s 
        public List<IndicatorQT1> IndicatorQT1s = new List<IndicatorQT1>();
        public double Q1 { get; set; }
        public string Q1Unit { get; set; }
        public double Q2 { get; set; }
        public string Q2Unit { get; set; }
        public double Q3 { get; set; }
        public string Q3Unit { get; set; }
        public double Q4 { get; set; }
        public string Q4Unit { get; set; }
        public double Q5 { get; set; }
        public string Q5Unit { get; set; }
        //210 added q6 to q11 for supplemental storage (not because UI changed)
        public double Q6 { get; set; }
        public string Q6Unit { get; set; }
        public double Q7 { get; set; }
        public string Q7Unit { get; set; }
        public double Q8 { get; set; }
        public string Q8Unit { get; set; }
        public double Q9 { get; set; }
        public string Q9Unit { get; set; }
        public double Q10 { get; set; }
        public string Q10Unit { get; set; }
        public double Q11 { get; set; }
        public string Q11Unit { get; set; }
        public double Q12 { get; set; }
        public string Q12Unit { get; set; }
        public double Q13 { get; set; }
        public string Q13Unit { get; set; }
        public double Q14 { get; set; }
        public string Q14Unit { get; set; }
        public double Q15 { get; set; }
        public string Q15Unit { get; set; }
        public double Q16 { get; set; }
        public string Q16Unit { get; set; }
        public double Q17 { get; set; }
        public string Q17Unit { get; set; }
        public double Q18 { get; set; }
        public string Q18Unit { get; set; }
        public double Q19 { get; set; }
        public string Q19Unit { get; set; }
        public double Q20 { get; set; }
        public string Q20Unit { get; set; }
        public double Q21 { get; set; }
        public string Q21Unit { get; set; }
        public double Q22 { get; set; }
        public string Q22Unit { get; set; }
        public double Q23 { get; set; }
        public string Q23Unit { get; set; }
        public double Q24 { get; set; }
        public string Q24Unit { get; set; }
        public double Q25 { get; set; }
        public string Q25Unit { get; set; }
        public double Q26 { get; set; }
        public string Q26Unit { get; set; }
        public double Q27 { get; set; }
        public string Q27Unit { get; set; }
        public double Q28 { get; set; }
        public string Q28Unit { get; set; }
        public double Q29 { get; set; }
        public string Q29Unit { get; set; }
        public double Q30 { get; set; }
        public string Q30Unit { get; set; }
        public double QTM { get; set; }
        public double QTL { get; set; }
        public double QTU { get; set; }
        public double QT { get; set; }
        public double QTD1 { get; set; }
        public double QTD2 { get; set; }
        public string QTMUnit { get; set; }
        public string QTLUnit { get; set; }
        public string QTUUnit { get; set; }
        public string QTUnit { get; set; }
        public string QTD1Unit { get; set; }
        public string QTD2Unit { get; set; }
        public string QMathType { get; set; }
        public string QMathSubType { get; set; }
        public string QDistributionType { get; set; }
        public string QMathExpression { get; set; }
        //specialty use in specific algorithms (2.0.8 started init and copying)
        public string[] Indicators = new string[] { };
        public virtual void InitIndicatorQT1sProperties()
        {
            if (this.IndicatorQT1s == null)
            {
                this.IndicatorQT1s = new List<IndicatorQT1>();
            }
            if (this.IndicatorQT1s.Count() > 0)
            {
                foreach (IndicatorQT1 indQ in this.IndicatorQT1s)
                {
                    InitIndicatorQT1Properties(indQ);
                }
            }
            //and prevent null refs to parent
            InitIndicatorQT1Properties(this);
        }
        private void InitIndicatorQT1Properties(IndicatorQT1 indQ)
        {
            //avoid null references to properties
            indQ.Q1 = 0;
            indQ.Q1Unit = string.Empty;
            indQ.Q2 = 0;
            indQ.Q2Unit = string.Empty;
            indQ.Q3 = 0;
            indQ.Q3Unit = string.Empty;
            indQ.Q4 = 0;
            indQ.Q4Unit = string.Empty;
            indQ.Q5 = 0;
            indQ.Q5Unit = string.Empty;
            indQ.Q6 = 0;
            indQ.Q6Unit = string.Empty;
            indQ.Q7 = 0;
            indQ.Q7Unit = string.Empty;
            indQ.Q8 = 0;
            indQ.Q8Unit = string.Empty;
            indQ.Q9 = 0;
            indQ.Q9Unit = string.Empty;
            indQ.Q10 = 0;
            indQ.Q10Unit = string.Empty;
            indQ.Q11 = 0;
            indQ.Q11Unit = string.Empty;
            indQ.Q12 = 0;
            indQ.Q12Unit = string.Empty;
            indQ.Q13 = 0;
            indQ.Q13Unit = string.Empty;
            indQ.Q14 = 0;
            indQ.Q14Unit = string.Empty;
            indQ.Q15 = 0;
            indQ.Q15Unit = string.Empty;
            indQ.Q16 = 0;
            indQ.Q16Unit = string.Empty;
            indQ.Q17 = 0;
            indQ.Q17Unit = string.Empty;
            indQ.Q18 = 0;
            indQ.Q18Unit = string.Empty;
            indQ.Q19 = 0;
            indQ.Q19Unit = string.Empty;
            indQ.Q20 = 0;
            indQ.Q20Unit = string.Empty;
            indQ.Q21 = 0;
            indQ.Q21Unit = string.Empty;
            indQ.Q22 = 0;
            indQ.Q22Unit = string.Empty;
            indQ.Q23 = 0;
            indQ.Q23Unit = string.Empty;
            indQ.Q24 = 0;
            indQ.Q24Unit = string.Empty;
            indQ.Q25 = 0;
            indQ.Q25Unit = string.Empty;
            indQ.Q26 = 0;
            indQ.Q26Unit = string.Empty;
            indQ.Q27 = 0;
            indQ.Q27Unit = string.Empty;
            indQ.Q28 = 0;
            indQ.Q28Unit = string.Empty;
            indQ.Q29 = 0;
            indQ.Q29Unit = string.Empty;
            indQ.Q30 = 0;
            indQ.Q30Unit = string.Empty;
            indQ.QTM = 0;
            indQ.QTL = 0;
            indQ.QTU = 0;
            indQ.QT = 0;
            indQ.QTD1 = 0;
            indQ.QTD2 = 0;
            indQ.QTMUnit = string.Empty;
            indQ.QTLUnit = string.Empty;
            indQ.QTUUnit = string.Empty;
            indQ.QTUnit = string.Empty;
            indQ.QTD1Unit = string.Empty;
            indQ.QTD2Unit = string.Empty;
            indQ.QMathType = string.Empty;
            indQ.QMathSubType = string.Empty;
            indQ.QDistributionType = string.Empty;
            indQ.QMathExpression = string.Empty;
            //don't overwrite URLs
            if (!indQ.MathResult.ToLower().StartsWith("http"))
            {
                indQ.MathResult = string.Empty;
            }
            indQ.Indicators = new string[] { };
        }
        public static void InitIndicatorQT1MathProperties(IndicatorQT1 indQ)
        {
            //avoid null references to properties
            indQ.Q1 = 0;
            indQ.Q2 = 0;
            indQ.Q3 = 0;
            indQ.Q4 = 0;
            indQ.Q5 = 0;
            indQ.Q6 = 0;
            indQ.Q7 = 0;
            indQ.Q8 = 0;
            indQ.Q9 = 0;
            indQ.Q10 = 0;
            indQ.Q11 = 0;
            indQ.Q12 = 0;
            indQ.Q13 = 0;
            indQ.Q14 = 0;
            indQ.Q15 = 0;
            indQ.Q16 = 0;
            indQ.Q17 = 0;
            indQ.Q18 = 0;
            indQ.Q19 = 0;
            indQ.Q20 = 0;
            indQ.Q21 = 0;
            indQ.Q22 = 0;
            indQ.Q23 = 0;
            indQ.Q24 = 0;
            indQ.Q25 = 0;
            indQ.Q26 = 0;
            indQ.Q27 = 0;
            indQ.Q28 = 0;
            indQ.Q29 = 0;
            indQ.Q30 = 0;
            indQ.QTM = 0;
            indQ.QTL = 0;
            indQ.QTU = 0;
            indQ.QT = 0;
            indQ.QTD1 = 0;
            indQ.QTD2 = 0;
            //units must not be null
            if (indQ.Q1Unit == null)
                indQ.Q1Unit = string.Empty;
            if (indQ.Q2Unit == null)
                indQ.Q2Unit = string.Empty;
            if (indQ.Q3Unit == null)
                indQ.Q3Unit = string.Empty;
            if (indQ.Q4Unit == null)
                indQ.Q4Unit = string.Empty;
            if (indQ.Q5Unit == null)
                indQ.Q5Unit = string.Empty;
            if (indQ.Q6Unit == null)
                indQ.Q6Unit = string.Empty;
            if (indQ.Q7Unit == null)
                indQ.Q7Unit = string.Empty;
            if (indQ.Q8Unit == null)
                indQ.Q8Unit = string.Empty;
            if (indQ.Q9Unit == null)
                indQ.Q9Unit = string.Empty;
            if (indQ.Q10Unit == null)
                indQ.Q10Unit = string.Empty;
            if (indQ.Q11Unit == null)
                indQ.Q11Unit = string.Empty;
            if (indQ.Q12Unit == null)
                indQ.Q12Unit = string.Empty;
            if (indQ.Q13Unit == null)
                indQ.Q13Unit = string.Empty;
            if (indQ.Q14Unit == null)
                indQ.Q14Unit = string.Empty;
            if (indQ.Q15Unit == null)
                indQ.Q15Unit = string.Empty;
            if (indQ.Q16Unit == null)
                indQ.Q16Unit = string.Empty;
            if (indQ.Q17Unit == null)
                indQ.Q17Unit = string.Empty;
            if (indQ.Q18Unit == null)
                indQ.Q18Unit = string.Empty;
            if (indQ.Q19Unit == null)
                indQ.Q19Unit = string.Empty;
            if (indQ.Q20Unit == null)
                indQ.Q20Unit = string.Empty;
            if (indQ.Q21Unit == null)
                indQ.Q21Unit = string.Empty;
            if (indQ.Q22Unit == null)
                indQ.Q22Unit = string.Empty;
            if (indQ.Q23Unit == null)
                indQ.Q23Unit = string.Empty;
            if (indQ.Q24Unit == null)
                indQ.Q24Unit = string.Empty;
            if (indQ.Q25Unit == null)
                indQ.Q25Unit = string.Empty;
            if (indQ.Q26Unit == null)
                indQ.Q26Unit = string.Empty;
            if (indQ.Q27Unit == null)
                indQ.Q27Unit = string.Empty;
            if (indQ.Q28Unit == null)
                indQ.Q28Unit = string.Empty;
            if (indQ.Q29Unit == null)
                indQ.Q29Unit = string.Empty;
            if (indQ.Q30Unit == null)
                indQ.Q30Unit = string.Empty;
            if (indQ.QTMUnit == null)
                indQ.QTMUnit = string.Empty;
            if (indQ.QTLUnit == null)
                indQ.QTLUnit = string.Empty;
            if (indQ.QTUUnit == null)
                indQ.QTUUnit = string.Empty;
            if (indQ.QTUnit == null)
                indQ.QTUnit = string.Empty;
            if (indQ.QTD1Unit == null)
                indQ.QTD1Unit = string.Empty;
            if (indQ.QTD2Unit == null)
                indQ.QTD2Unit = string.Empty;
            if (indQ.Indicators == null)
                indQ.Indicators = new string[] { };
        }
        public virtual void CopyIndicatorQT1sProperties(
            IndicatorQT1 calculator)
        {
            if (calculator == null)
                calculator = new IndicatorQT1();
            if (calculator.IndicatorQT1s == null)
                calculator.IndicatorQT1s = new List<IndicatorQT1>();
            if (calculator.IndicatorQT1s.Count() > 0)
            {
                foreach (IndicatorQT1 calculatorInd in calculator.IndicatorQT1s)
                {
                    IndicatorQT1 qt = new IndicatorQT1(calculatorInd);
                    this.IndicatorQT1s.Add(qt);
                }
                //need all 21 indicators because methods have conditions that must check all 21 (i.e. if label ==)
                //remember that score is the first indicator plus 20 regular ones
                for (int i = (this.IndicatorQT1s.Count - 1); i < 20; i++)
                {
                    IndicatorQT1 qt = new IndicatorQT1();
                    this.IndicatorQT1s.Add(qt);
                }
            }
            //prevent null refs
            CopyIndicatorQT1Properties(this, calculator);
        }
        public void CopyIndicatorQT1Properties(IndicatorQT1 indQ,
            IndicatorQT1 calculator)
        {
            //should be able to replace this with new c#5 syntax
            if (calculator == null)
                calculator = new IndicatorQT1();
            if (indQ == null)
                indQ = new IndicatorQT1();
            indQ.Label = calculator.Label;
            indQ.Q1 = calculator.Q1;
            indQ.Q1Unit = calculator.Q1Unit;
            indQ.Q2 = calculator.Q2;
            indQ.Q2Unit = calculator.Q2Unit;
            indQ.Q3 = calculator.Q3;
            indQ.Q3Unit = calculator.Q3Unit;
            indQ.Q4 = calculator.Q4;
            indQ.Q4Unit = calculator.Q4Unit;
            indQ.Q5 = calculator.Q5;
            indQ.Q5Unit = calculator.Q5Unit;
            indQ.Q6 = calculator.Q6;
            indQ.Q6Unit = calculator.Q6Unit;
            indQ.Q7 = calculator.Q7;
            indQ.Q7Unit = calculator.Q7Unit;
            indQ.Q8 = calculator.Q8;
            indQ.Q8Unit = calculator.Q8Unit;
            indQ.Q9 = calculator.Q9;
            indQ.Q9Unit = calculator.Q9Unit;
            indQ.Q10 = calculator.Q10;
            indQ.Q10Unit = calculator.Q10Unit;
            indQ.Q11 = calculator.Q11;
            indQ.Q11Unit = calculator.Q11Unit;
            indQ.Q12 = calculator.Q12;
            indQ.Q12Unit = calculator.Q12Unit;
            indQ.Q13 = calculator.Q13;
            indQ.Q13Unit = calculator.Q13Unit;
            indQ.Q14 = calculator.Q14;
            indQ.Q14Unit = calculator.Q14Unit;
            indQ.Q15 = calculator.Q15;
            indQ.Q15Unit = calculator.Q15Unit;
            indQ.Q16 = calculator.Q16;
            indQ.Q16Unit = calculator.Q16Unit;
            indQ.Q17 = calculator.Q17;
            indQ.Q17Unit = calculator.Q17Unit;
            indQ.Q18 = calculator.Q18;
            indQ.Q18Unit = calculator.Q18Unit;
            indQ.Q19 = calculator.Q19;
            indQ.Q19Unit = calculator.Q19Unit;
            indQ.Q20 = calculator.Q20;
            indQ.Q20Unit = calculator.Q20Unit;
            indQ.Q21 = calculator.Q21;
            indQ.Q21Unit = calculator.Q21Unit;
            indQ.Q22 = calculator.Q22;
            indQ.Q22Unit = calculator.Q22Unit;
            indQ.Q23 = calculator.Q23;
            indQ.Q23Unit = calculator.Q23Unit;
            indQ.Q24 = calculator.Q24;
            indQ.Q24Unit = calculator.Q24Unit;
            indQ.Q25 = calculator.Q25;
            indQ.Q25Unit = calculator.Q25Unit;
            indQ.Q26 = calculator.Q26;
            indQ.Q26Unit = calculator.Q26Unit;
            indQ.Q27 = calculator.Q27;
            indQ.Q27Unit = calculator.Q27Unit;
            indQ.Q28 = calculator.Q28;
            indQ.Q28Unit = calculator.Q28Unit;
            indQ.Q29 = calculator.Q29;
            indQ.Q29Unit = calculator.Q29Unit;
            indQ.Q30 = calculator.Q30;
            indQ.Q30Unit = calculator.Q30Unit;
            indQ.QTM = calculator.QTM;
            indQ.QTL = calculator.QTL;
            indQ.QTU = calculator.QTU;
            indQ.QT = calculator.QT;
            indQ.QTD1 = calculator.QTD1;
            indQ.QTD2 = calculator.QTD2;
            indQ.QTMUnit = calculator.QTMUnit;
            indQ.QTLUnit = calculator.QTLUnit;
            indQ.QTUUnit = calculator.QTUUnit;
            indQ.QTUnit = calculator.QTUnit;
            indQ.QTD1Unit = calculator.QTD1Unit;
            indQ.QTD2Unit = calculator.QTD2Unit;
            indQ.QMathType = calculator.QMathType;
            indQ.QMathSubType = calculator.QMathSubType;
            indQ.QDistributionType = calculator.QDistributionType;
            indQ.QMathExpression = calculator.QMathExpression;
            indQ.MathResult = calculator.MathResult;
            indQ.Indicators = calculator.Indicators;
        }
        public static void FillIndicatorQT1Property(IndicatorQT1 indQ,
            int propertyIndex, double propertyValue, string propertyUnit)
        {
            if (indQ == null)
                indQ = new IndicatorQT1();
            if (propertyIndex == 1)
            {
                indQ.Q1 = propertyValue;
                indQ.Q1Unit = propertyUnit;
            }
            else if (propertyIndex == 2)
            {
                indQ.Q2 = propertyValue;
                indQ.Q2Unit = propertyUnit;
            }
            else if (propertyIndex == 3)
            {
                indQ.Q3 = propertyValue;
                indQ.Q3Unit = propertyUnit;
            }
            else if (propertyIndex == 4)
            {
                indQ.Q4 = propertyValue;
                indQ.Q4Unit = propertyUnit;
            }
            else if (propertyIndex == 5)
            {
                indQ.Q5 = propertyValue;
                indQ.Q5Unit = propertyUnit;
            }
            else if (propertyIndex == 6)
            {
                indQ.Q6 = propertyValue;
                indQ.Q6Unit = propertyUnit;
            }
            else if (propertyIndex == 7)
            {
                indQ.Q7 = propertyValue;
                indQ.Q7Unit = propertyUnit;
            }
            else if (propertyIndex == 8)
            {
                indQ.Q8 = propertyValue;
                indQ.Q8Unit = propertyUnit;
            }
            else if (propertyIndex == 9)
            {
                indQ.Q9 = propertyValue;
                indQ.Q9Unit = propertyUnit;
            }
            else if (propertyIndex == 10)
            {
                indQ.Q10 = propertyValue;
                indQ.Q10Unit = propertyUnit;
            }
            else if (propertyIndex == 11)
            {
                indQ.Q11 = propertyValue;
                indQ.Q11Unit = propertyUnit;
            }
            else if (propertyIndex == 12)
            {
                indQ.Q12 = propertyValue;
                indQ.Q12Unit = propertyUnit;
            }
            else if (propertyIndex == 13)
            {
                indQ.Q13 = propertyValue;
                indQ.Q13Unit = propertyUnit;
            }
            else if (propertyIndex == 14)
            {
                indQ.Q14 = propertyValue;
                indQ.Q14Unit = propertyUnit;
            }
            else if (propertyIndex == 15)
            {
                indQ.Q15 = propertyValue;
                indQ.Q15Unit = propertyUnit;
            }
            else if (propertyIndex == 16)
            {
                indQ.Q16 = propertyValue;
                indQ.Q16Unit = propertyUnit;
            }
            else if (propertyIndex == 17)
            {
                indQ.Q17 = propertyValue;
                indQ.Q17Unit = propertyUnit;
            }
            else if (propertyIndex == 18)
            {
                indQ.Q18 = propertyValue;
                indQ.Q18Unit = propertyUnit;
            }
            else if (propertyIndex == 19)
            {
                indQ.Q19 = propertyValue;
                indQ.Q19Unit = propertyUnit;
            }
            else if (propertyIndex == 20)
            {
                indQ.Q20 = propertyValue;
                indQ.Q20Unit = propertyUnit;
            }
            else if (propertyIndex == 21)
            {
                indQ.Q21 = propertyValue;
                indQ.Q21Unit = propertyUnit;
            }
            else if (propertyIndex == 22)
            {
                indQ.Q22 = propertyValue;
                indQ.Q22Unit = propertyUnit;
            }
            else if (propertyIndex == 23)
            {
                indQ.Q23 = propertyValue;
                indQ.Q23Unit = propertyUnit;
            }
            else if (propertyIndex == 24)
            {
                indQ.Q24 = propertyValue;
                indQ.Q24Unit = propertyUnit;
            }
            else if (propertyIndex == 25)
            {
                indQ.Q25 = propertyValue;
                indQ.Q25Unit = propertyUnit;
            }
            else if (propertyIndex == 26)
            {
                indQ.Q26 = propertyValue;
                indQ.Q26Unit = propertyUnit;
            }
            else if (propertyIndex == 27)
            {
                indQ.Q27 = propertyValue;
                indQ.Q27Unit = propertyUnit;
            }
            else if (propertyIndex == 28)
            {
                indQ.Q28 = propertyValue;
                indQ.Q28Unit = propertyUnit;
            }
            else if (propertyIndex == 29)
            {
                indQ.Q29 = propertyValue;
                indQ.Q29Unit = propertyUnit;
            }
            else if (propertyIndex == 30)
            {
                indQ.Q30 = propertyValue;
                indQ.Q30Unit = propertyUnit;
            }
        }
        public void CopyIndicatorQT1MathProperties(IndicatorQT1 indQ,
        IndicatorQT1 calculator)
        {
            //do not overwrite the Q1 to Q5 props entered on ui
            //if they need updating, use CopyIndicatorQT1Properties
            indQ.QTM = calculator.QTM;
            indQ.QTL = calculator.QTL;
            indQ.QTU = calculator.QTU;
            //do not include QT - handled separately using mathexpress
            indQ.QTD1 = calculator.QTD1;
            indQ.QTD2 = calculator.QTD2;
            //conditional overwrite
            if (string.IsNullOrEmpty(indQ.QTMUnit))
                indQ.QTMUnit = calculator.QTMUnit;
            if (string.IsNullOrEmpty(indQ.QTD1Unit))
                indQ.QTD1Unit = calculator.QTD1Unit;
            if (string.IsNullOrEmpty(indQ.QTD2Unit))
                indQ.QTD2Unit = calculator.QTD2Unit;
            //overwrite w confid ints
            indQ.QTLUnit = calculator.QTLUnit;
            indQ.QTUUnit = calculator.QTUUnit;
            indQ.MathResult = calculator.MathResult;
            if (indQ.Indicators == null)
                indQ.Indicators = calculator.Indicators;
        }
        public static List<string> GetIndicatorColNames()
        {
            List<string> colNames = new List<string>();
            for (int i = 0; i < 11; i++)
            {
                colNames.Add(string.Concat("factor", i.ToString()));
            }
            return colNames;
        }
        public static List<List<string>> GetDefaultData()
        {
            //just need to init data to get to Calc1.DataToAnalyze
            List<List<string>> colData = new List<List<string>>();
            colData.Add(GetIndicatorColNames());
            return colData;
        }
    }
}
