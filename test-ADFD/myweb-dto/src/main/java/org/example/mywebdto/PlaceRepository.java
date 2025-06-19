package org.example.mywebdto;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository<Place, Long> {

    /**
     * Find all places ordered by rating (highest first)
     * @return List of places sorted by rating
     */
    @Query("SELECT p FROM Place p ORDER BY p.rating DESC")
    List<Place> findAllOrderByRatingDesc();

    /**
     * Find places by name containing keyword (case insensitive)
     * @param name Name keyword to search
     * @return List of places matching the keyword
     */
    @Query("SELECT p FROM Place p WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', ?1, '%'))")
    List<Place> findByNameContainingIgnoreCase(String name);

    /**
     * Find places with rating greater than specified value
     * @param rating Minimum rating
     * @return List of places with rating above the specified value
     */
    List<Place> findByRatingGreaterThan(double rating);
}