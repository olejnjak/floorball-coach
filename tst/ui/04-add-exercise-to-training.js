var target = UIATarget.localTarget();
var testName = "Add exercise to training";

target.frontMostApp().mainWindow().collectionViews()[0].cells()["[Training list]"].buttons()[0].tap();

var count = target.frontMostApp().mainWindow().tableViews()[0].cells().length;

target.frontMostApp().mainWindow().tableViews()[0].cells()[0].tap();
target.frontMostApp().mainWindow().collectionViews()[0].tapWithOptions({tapOffset:{x:0.20, y:0.35}});
target.frontMostApp().toolbar().buttons()["[Back]"].tap();

var count2 = target.frontMostApp().mainWindow().tableViews()[0].cells().length;

if (count + 1 == count2)
{
	UIALogger.logPass(testName);
}
else
{
	UIALogger.logFail(testName);
}
