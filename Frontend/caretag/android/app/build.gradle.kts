plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}


android {
    namespace = "com.example.caretag"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
  sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        
        // 2. THIS IS THE KEY LINE FOR KOTLIN DSL
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget ="1.8"
    }

 defaultConfig {
        applicationId = "com.example.caretag"
        minSdk = flutter.minSdkVersion // Manually set to 21 for stability with desugaring
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        multiDexEnabled = true // Add this line
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation(platform("com.google.firebase:firebase-bom:34.9.0"))
    implementation("com.google.firebase:firebase-analytics")
}
}

flutter {
    source = "../.."
}
