var target = UIATarget.localTarget();
var testName = "Add exercise to training";

target.frontMostApp().mainWindow().collectionViews()[0].cells()["[Training list]"].buttons()["border"].tap();

var count = target.frontMostApp().mainWindow().tableViews()["Empty list"].cells().length;

target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].tap();
target.frontMostApp().mainWindow().collectionViews()[0].tapWithOptions({tapOffset:{x:0.17, y:0.57}});
target.frontMostApp().toolbar().buttons()["[Back]"].tap();

var count2 = target.frontMostApp().mainWindow().tableViews()["Empty list"].cells().length;

if (count + 1 == count2)
{
	UIALogger.logPass(testName);
}
else
{
	UIALogger.logFail(testName);
}
