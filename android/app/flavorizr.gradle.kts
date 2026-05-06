import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.salait.dev"
            resValue(type = "string", name = "app_name", value = "Salait-dev")
        }
        create("product") {
            dimension = "flavor-type"
            applicationId = "com.salait.blog"
            resValue(type = "string", name = "app_name", value = "SalaitBlog")
        }
    }
}