part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends PlaceState {}

class SearchLoading extends PlaceState {}

class SearchLoaded extends PlaceState {
  final List<PlacesSearchResult> places;
  const SearchLoaded(this.places);
}
