import 'package:snt_app/Models/department_model.dart';

class DepartmentsData {
  static List<DepartmentModel> get departments => [
    DepartmentModel(
      name: "HR",
      description: "Responsible for recruiting, onboarding, and managing members of Skill&Tell. Ensures smooth communication and member satisfaction within the club.",
      imageUrl: "https://<your-project-ref>.supabase.co/storage/v1/object/public/departments/hr.png"
    ),
    DepartmentModel(
      name: "DESIGN",
      description: "Handles all creative aspects of Skill&Tell, including graphics, branding, and visual identity for events and projects.",
      imageUrl: "https://<your-project-ref>.supabase.co/storage/v1/object/public/departments/design.png"
    ),
    DepartmentModel(
      name: "MARKETING",
      description: "Promotes Skill&Tell events and initiatives through social media, partnerships, and campaigns to engage the community.",
      imageUrl: "https://<your-project-ref>.supabase.co/storage/v1/object/public/departments/marketing.png"
    ),
    DepartmentModel(
      name: "IT",
      description: "Focuses on technical development, managing digital platforms, and supporting projects involving software, AI, and web technologies.",
      imageUrl: "https://<your-project-ref>.supabase.co/storage/v1/object/public/departments/it.png"
    ),
    DepartmentModel(
      name: "EVENT",
      description: "Plans, organizes, and executes Skill&Tell events, workshops, and competitions to ensure memorable experiences for participants.",
      imageUrl: "https://<your-project-ref>.supabase.co/storage/v1/object/public/departments/event.png"
    ),
  ];
}