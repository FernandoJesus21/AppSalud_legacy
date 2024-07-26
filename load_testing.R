shinyloadtest::record_session('http://109.205.182.206:3838/')

#shinycannon recording.log http://109.205.182.206:3838/appSalud/ --workers 15 --loaded-duration-minutes 10 --output-dir run2

df <- shinyloadtest::load_runs("test/dashboard_test")
shinyloadtest::shinyloadtest_report(df, "test/dashboard_test.html")

df <- shinyloadtest::load_runs("test/mapas_test")
shinyloadtest::shinyloadtest_report(df, "test/mapas_test.html")

df <- shinyloadtest::load_runs("test/tendencias_test")
shinyloadtest::shinyloadtest_report(df, "test/tendencias_test.html")

###################
#hardcore tests

df <- shinyloadtest::load_runs("test/dashboard_test_h")
shinyloadtest::shinyloadtest_report(df, "test/dashboard_test_h.html")

df <- shinyloadtest::load_runs("test/mapas_test_h")
shinyloadtest::shinyloadtest_report(df, "test/mapas_test_h.html")

df <- shinyloadtest::load_runs("test/tendencias_test_h")
shinyloadtest::shinyloadtest_report(df, "test/tendencias_test_h.html")



