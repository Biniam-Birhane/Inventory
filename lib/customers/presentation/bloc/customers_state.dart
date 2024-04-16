part of 'customers_bloc.dart';

class CustomersState extends Equatable {
  const CustomersState(
      {this.addCustomerstatus = FormzSubmissionStatus.initial,
      this.updateCustomerstatus = FormzSubmissionStatus.initial,
      this.deleteCustomerStatus = FormzSubmissionStatus.initial,
      this.getCustomerStatus = FormzSubmissionStatus.initial,
      this.customers = const <CustomerEntity>[],
      this.errorMessage = ''});

  final FormzSubmissionStatus addCustomerstatus;
  final FormzSubmissionStatus updateCustomerstatus;
  final FormzSubmissionStatus deleteCustomerStatus;
  final FormzSubmissionStatus getCustomerStatus;
  final List<CustomerEntity> customers;
  final String errorMessage;

  CustomersState copyWith({
    FormzSubmissionStatus? addCustomerstatus,
    FormzSubmissionStatus? updateCustomerstatus,
    FormzSubmissionStatus? deleteCustomerStatus,
    FormzSubmissionStatus? getCustomerStatus,
    List<CustomerEntity>? customers,
    String? errorMessage,
  }) {
    return CustomersState(
        addCustomerstatus: addCustomerstatus ?? this.addCustomerstatus,
        updateCustomerstatus: updateCustomerstatus ?? this.updateCustomerstatus,
        deleteCustomerStatus: deleteCustomerStatus ?? this.deleteCustomerStatus,
        getCustomerStatus: getCustomerStatus ?? this.getCustomerStatus,
        customers: customers ?? this.customers,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        addCustomerstatus,
        updateCustomerstatus,
        deleteCustomerStatus,
        getCustomerStatus,
        customers,
        errorMessage
      ];
}
