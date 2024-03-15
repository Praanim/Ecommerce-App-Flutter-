import 'package:eccomerce_frontend/core/services/providers/dio_network_service_provider.dart';
import 'package:eccomerce_frontend/features/orders/data/datasource/orders_data_source.dart';
import 'package:eccomerce_frontend/features/orders/data/repositories/order_repository.dart';
import 'package:eccomerce_frontend/features/orders/domain/repositories/order_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderDataSourceProvider = Provider<OrdersDataSource>((ref) =>
    OrderRemoteDataSource(
        dioNetworkService: ref.watch(networkServiceProvider)));

final orderRepoProvider = Provider<OrderRepository>((ref) =>
    OrderRepositoryImpl(ordersDataSource: ref.watch(orderDataSourceProvider)));
