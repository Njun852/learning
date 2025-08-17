using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.Playwright;
using Microsoft.Playwright.NUnit;
using NUnit.Framework;

namespace PlaywrightTesting;

[Parallelizable(ParallelScope.Self)]
[TestFixture]
public class ExampleTest : PageTest
{

    [Test]
    public async Task OpenedLoginButton()
    {

        await Page.GotoAsync("https://elms.sti.edu/");
        await Page.GetByRole(AriaRole.Link, new() { Name = " Log in " }).ClickAsync();
        await Page.Locator(".sso_btn").ClickAsync();
        await Page.GetByPlaceholder("Email or phone").FillAsync("juntilla.300511@gensan.sti.edu.ph");
        await Page.Locator("#idSIButton9").ClickAsync();
        await Page.GetByPlaceholder("Password").FillAsync("pass");
        await Page.Locator("#idSIButton9").ClickAsync();

        Thread.Sleep(4000);
    }
}