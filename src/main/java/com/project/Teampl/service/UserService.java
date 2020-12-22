package com.project.Teampl.service;


import com.project.Teampl.model.User;

import java.util.List;

public interface UserService {
    List<User> findAll();

    User findById(int useridx);

    void deleteById(int useridx);

    User save(User user);

    void updateById(int useridx, User user);

}
