package org.example.mywebdto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class PlaceController {

    @Autowired
    private PlaceRepository placeRepository;

    /**
     * API to get all places
     * GET /api/getAllPlace
     * @return List of all places
     */
    @GetMapping("/getAllPlace")
    public ResponseEntity<List<Place>> getAllPlace() {
        try {
            List<Place> places = placeRepository.findAll();

            // Return empty list if no places found
            if (places.isEmpty()) {
                return ResponseEntity.ok(places);
            }

            return ResponseEntity.ok(places);
        } catch (Exception e) {
            // Log error and return internal server error
            System.err.println("Error fetching places: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * Optional: API to get place by ID
     * GET /api/getPlace/{id}
     * @param id Place ID
     * @return Single place object
     */
    @GetMapping("/getPlace/{id}")
    public ResponseEntity<Place> getPlaceById(@PathVariable Long id) {
        try {
            return placeRepository.findById(id)
                    .map(place -> ResponseEntity.ok(place))
                    .orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            System.err.println("Error fetching place by ID: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * Optional: API to create new place
     * POST /api/createPlace
     * @param place Place object to create
     * @return Created place object
     */
    @PostMapping("/createPlace")
    public ResponseEntity<Place> createPlace(@RequestBody Place place) {
        try {
            Place savedPlace = placeRepository.save(place);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedPlace);
        } catch (Exception e) {
            System.err.println("Error creating place: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}