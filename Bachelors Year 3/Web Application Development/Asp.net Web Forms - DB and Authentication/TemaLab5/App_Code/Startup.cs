using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TemaLab5.Startup))]
namespace TemaLab5
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
