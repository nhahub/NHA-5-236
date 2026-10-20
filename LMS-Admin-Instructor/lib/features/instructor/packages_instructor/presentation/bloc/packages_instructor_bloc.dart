import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/repository/courses_instructor_repository.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/domain/repository/packages_instructor_repository.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_state.dart';

class PackagesInstructorBloc
    extends Bloc<PackagesInstructorEvent, PackagesInstructorState> {
  final PackagesInstructorRepository packagesRepository;
  final CoursesInstructorRepository coursesRepository;

  PackagesInstructorBloc({
    required this.packagesRepository,
    required this.coursesRepository,
  }) : super(PackagesInstructorInitial()) {
    on<GetInstructorCoursesForPackageEvent>(_onGetCourses);
    on<CreatePackageEvent>(_onCreatePackage);
    on<GetInstructorPackagesEvent>(_onGetPackages);
    on<DeletePackageEvent>(_onDeletePackage);
  }

  Future<void> _onDeletePackage(
    DeletePackageEvent event,
    Emitter<PackagesInstructorState> emit,
  ) async {
    final currentState = state;
    emit(DeletePackageLoading());
    
    final response = await packagesRepository.deletePackage(slug: event.slug);
    
    response.fold(
      (error) {
        emit(DeletePackageError(message: error));
        if (currentState is PackagesListLoaded) {
          emit(currentState);
        }
      },
      (success) {
        emit(DeletePackageSuccess(message: success));
        add(GetInstructorPackagesEvent(instructorSlug: event.instructorSlug, page: 1));
      },
    );
  }

  Future<void> _onGetPackages(
    GetInstructorPackagesEvent event,
    Emitter<PackagesInstructorState> emit,
  ) async {
    final currentState = state;
    if (currentState is PackagesListLoaded && event.page > 1) {
      emit(currentState.copyWith(isPaginationLoading: true));
    } else {
      emit(PackagesListLoading());
    }

    final response = await packagesRepository.getPackagesInstructor(
      instructorSlug: event.instructorSlug,
      page: event.page,
      search: event.search,
    );

    response.fold(
      (error) {
        emit(PackagesListError(message: error));
      },
      (packagesListUIModel) {
        if (currentState is PackagesListLoaded && event.page > 1) {
          final updatedPackages = List.of(currentState.packagesListUIModel.packages)
            ..addAll(packagesListUIModel.packages);

          emit(
            PackagesListLoaded(
              packagesListUIModel: packagesListUIModel.copyWithItems(
                updatedPackages,
                currentPage: event.page,
                totalPages: packagesListUIModel.totalPages,
              ),
              isPaginationLoading: false,
            ),
          );
        } else {
          emit(
            PackagesListLoaded(
              packagesListUIModel: packagesListUIModel,
              isPaginationLoading: false,
            ),
          );
        }
      },
    );
  }

  Future<void> _onGetCourses(
    GetInstructorCoursesForPackageEvent event,
    Emitter<PackagesInstructorState> emit,
  ) async {
    emit(InstructorCoursesLoading());
    final response = await coursesRepository.getCoursesInstructor(
      instructorSlug: event.instructorSlug,
      pageSize: 1000,
    );

    response.fold((error) => emit(InstructorCoursesError(message: error)), (
      responseModel,
    ) {
      final entity = responseModel.toEntity();
      emit(InstructorCoursesLoaded(courses: entity.courses));
    });
  }

  Future<void> _onCreatePackage(
    CreatePackageEvent event,
    Emitter<PackagesInstructorState> emit,
  ) async {
    final currentState = state;
    List<CourseInstructorItemUIModel> currentCourses = [];
    if (currentState is InstructorCoursesLoaded) {
      currentCourses = currentState.courses;
    } else if (currentState is CreatePackageError) {
      currentCourses = currentState.courses;
    } else if (currentState is CreatePackageSuccess) {
      currentCourses = currentState.courses;
    }

    emit(CreatePackageLoading(courses: currentCourses));

    final response = await packagesRepository.createPackage(
      requestModel: event.requestModel,
    );

    response.fold(
      (error) =>
          emit(CreatePackageError(message: error, courses: currentCourses)),
      (successMessage) {
        emit(
          CreatePackageSuccess(
            message: successMessage,
            courses: currentCourses,
          ),
        );
        emit(InstructorCoursesLoaded(courses: currentCourses));
      },
    );
  }
}
