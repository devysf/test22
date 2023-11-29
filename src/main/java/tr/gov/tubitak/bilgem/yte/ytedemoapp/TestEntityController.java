package tr.gov.tubitak.bilgem.yte.ytedemoapp;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/testEntity")
public class TestEntityController {

    @GetMapping("/hello")
    public String query() {
        return "hello world";
    }
}