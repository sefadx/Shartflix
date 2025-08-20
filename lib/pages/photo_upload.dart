import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/upload_photo/upload_bloc.dart';
import '../gen/app_localizations.dart';
import '../navigator/app_router.dart';
import '../navigator/pages.dart';
import '../theme/theme_extension.dart';

class PagePhotoUpload extends StatelessWidget {
  const PagePhotoUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>().auth!;
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return BlocProvider<UploadBloc>(
      create: (context) => UploadBloc(accessToken: auth.token),
      child: BlocListener<UploadBloc, UploadState>(
        listener: (context, state) {
          if (state is Uploading) {
            AppRouter.instance.push(const PopupLoadingRoute());
          } else if (state is Uploaded) {
            //AppRouter.instance.pop(route: const PopupLoadingRoute());
            //AppRouter.instance.push(PopupInfoRoute(title: text.success, message: text.uploaded));
            AppRouter.instance.replaceAll(HomeRoute());
          } else if (state is UploadFailed) {
            AppRouter.instance.pop(route: const PopupLoadingRoute());
            AppRouter.instance.push(PopupInfoRoute(title: text.failure, message: state.error));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: theme.colorScheme.background,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => AppRouter.instance.pop(),
            ),
            title: Text(text.profileDetail, style: theme.textTheme.titleMedium),
            actionsPadding: EdgeInsets.all(customTheme.gapmedium),
          ),
          body: BlocBuilder<UploadBloc, UploadState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(customTheme.gapxxxxlarge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text.uploadYourPhotos,
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: customTheme.gapmedium),
                    Text(
                      text.uploadYourPhotosDesc,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: customTheme.gapxxxxlarge),
                    InkWell(
                      borderRadius: BorderRadius.circular(customTheme.radiusxxlarge),
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final uploadBloc = context.read<UploadBloc>();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          uploadBloc.add(UploadPhoto(filePath: image.path));
                        }
                      },
                      child: Ink(
                        padding: EdgeInsets.all(customTheme.gapxxxxlarge),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(customTheme.radiusxxlarge),
                          border: Border.all(
                            color: theme.colorScheme.secondary.withAlpha(80),
                            width: 1,
                          ),
                          color: theme.colorScheme.surface,
                        ),
                        child: Icon(Icons.add, size: 50),
                      ),
                    ),
                    SizedBox(width: double.infinity),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
