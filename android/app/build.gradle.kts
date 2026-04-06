import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keyProperties = Properties()
val keyPropertiesFile = project.file("key.properties")
if (keyPropertiesFile.exists()) {
    keyProperties.load(FileInputStream(keyPropertiesFile))
}

android {
    namespace = "com.minvest.aisignals"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.minvest.aisignals"
        minSdkVersion(24)
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (keyPropertiesFile.exists()) {
                val alias = keyProperties.getProperty("keyAlias")
                val keyPass = keyProperties.getProperty("keyPassword")
                val storeFilePath = keyProperties.getProperty("storeFile")
                val storePass = keyProperties.getProperty("storePassword")
                
                if (alias != null && keyPass != null && storeFilePath != null && storePass != null) {
                    keyAlias = alias
                    keyPassword = keyPass
                    storeFile = project.file(storeFilePath)
                    storePassword = storePass
                } else {
                    println("🚨 Cảnh báo: key.properties tồn tại nhưng thiếu thuộc tính ký. Bản release sẽ không được ký đúng cách.")
                }
            } else {
                println("🚨 Cảnh báo: key.properties không tồn tại. Bản release sẽ không được ký.")
            }
        }
    }

    buildTypes {
        getByName("release") {
            // Chỉ gán signingConfig nếu các thông số đã được điền đủ
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("com.facebook.android:facebook-login:latest.release")
}
