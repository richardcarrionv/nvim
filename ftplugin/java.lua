local config = {
  cmd = { 'C:\\Users\\carri\\AppData\\Local\\nvim-data\\mason\\bin\\jdtls.cmd' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  configuration = {
    runtimes = {
      {
        name = "JavaSE-1.8",
        path = "C:\\Program Files\\Java\\jdk1.8.0_271",
      },
      {
        name = "JavaSE-17",
        path = "C:\\Program Files\\Java\\jdk-17",
        default = true,
      },
    },
  },
  java = {
    project = {
      referencedLibraries = {
        'C:/Users/carri/Workspace/eeasa/WSSisestudios/WebContent/WEB-INF/lib/javax.annotation-api-1.2.jar',
        'C:\\Users\\carri\\Workspace\\eeasa\\WSSisestudios\\WebContent\\WEB-INF\\lib\\json-20180813.jar',
        'C:\\Users\\carri\\Workspace\\eeasa\\WSSisestudios\\WebContent\\WEB-INF\\lib\\json.jar',
      },
    }
  }
}

require('jdtls').start_or_attach(config)
