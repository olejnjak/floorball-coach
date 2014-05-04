
var target = UIATarget.localTarget();
var testName = "Add new training";

target.frontMostApp().mainWindow().collectionViews()[0].cells()[3].buttons()["border"].tap();

var count = target.frontMostApp().mainWindow().tableViews()[0].cells().length;
target.frontMostApp().toolbar().buttons()["Add"].tap();
target.frontMostApp().toolbar().buttons()["[Back]"].tap();
UIATarget.localTarget().delay(1);

var count2 = target.frontMostApp().mainWindow().tableViews()[0].cells().length;

if (count == count2)
{
    UIALogger.logFail(testName);
}

else
{
    UIALogger.logPass(testName);
}
